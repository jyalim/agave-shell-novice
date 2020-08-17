import numpy as np
import pylab as plt
import matplotlib as mpl

mpl.use('Agg')

# Load columnar data file and skip header label row
t,signal = np.loadtxt('signal.dat',skiprows=1).T
# For the fft power model for a triangle wave
K = np.linspace(1,11,1001)
# Lazy fft, no detrending, no filtering, as signal is known to be
# triangle wave with zero mean.
q  = np.fft.fft(signal)[:len(signal)//2]
q  = q.real/q.real.max()
T  = t[-1]-t[0]+t[1]-t[0]
f0 = 2*np.pi/T
f  = f0 * np.arange(len(q))
plt.figure(figsize=(12,6))
plt.semilogy(f,q,'k-',lw=3)
plt.semilogy(K,1/K**2,'r--',lw=2)
plt.annotate(r'$k^{-2}$',(8,5e-2),fontsize=20,color='r',ha='center')
plt.xlim(0,10)
plt.ylim(1e-7,1e1)
plt.xticks(np.arange(11),fontsize=24)
plt.yticks(fontsize=24)
plt.grid(which='major',color='#999999',linestyle='--')
plt.grid(which='minor',color='#999999',linestyle=':')
plt.xlabel('Frequency',fontsize=28)
plt.ylabel('Relative Power',fontsize=28)
plt.savefig('fft.png',bbox_inches='tight')


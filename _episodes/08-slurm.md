---
title: "Using the Scheduler"
teaching: 30
exercises: 0
questions:
- "How can I run an interactive session on a compute node?"
- "How can I load the software that I need?"
- "How can I submit jobs?"
- "How can I monitor a job?"
- "How can I cancel a job that's pending or running?"
- "How can I monitor resources?"
objectives:
- "Understand the module system."
- "Write a shell script that runs a command or series of commands for a fixed set of files, and run it interactively on a compute node."
- "Write a shell script that runs a command or series of commands for a fixed set of files, and submit as a job."
- "Learn how to cancel running compute jobs."
- "Learn how to monitor jobs and compute resources."
keypoints:
- "The module system keeps the cluster environment adaptive to each researcher."
- "Interactive sessions are useful for debugging or active job monitoring, e.g. `htop`."
- "Using the scheduler to submit scripts through `sbatch` is an ultimate
  scaling goal""
- "Many commands are provided to aide the researcher, e.g. `myjobs`,
  `showparts`, or `interactive`"
---

In this section we will take all that we learned thus far and build on
it to run software on [Agave's compute
nodes](https://asurc.atlassian.net/wiki/spaces/RC/pages/45875228/Compute+Nodes).
We will demonstrate some of the basics of interacting with the cluster
and scheduler through the command line, such as using the module file
system or using the `interactive` command.  We are going to take the
commands we repeat frequently and save them in files that can be
submitted to compute nodes for asynchronous completion.  

We will begin by first examining the example workflow that we will be
working with. 

~~~
$ cd ~/Desktop/data-shell/signal
$ ls
~~~
{: .language-bash}

~~~
fft.png  get_fft.py  my_signal_processing_job.sh  signal.dat  signal.png
~~~
{: .output}

In this example, we will be working with some time series data,
specifically that associated with a [triangle wave](https://en.wikipedia.org/wiki/Triangle_wave).
The time series `signal.png` is shown below:

![Time series of the example triangle wave](data-shell/signal/signal.png)

The data associated with this triangle wave is included in `signal.dat`,
and the first ten lines will be outputted to the terminal with `head`:

~~~
$ head signal.dat
~~~
{: .language-bash}

~~~
time                     signal
0.000000000000000000e+00 1.208721311121388364e+00
6.283185307179586614e-03 1.208524005375646748e+00
1.256637061435917323e-02 1.207933122945394233e+00
1.884955592153875897e-02 1.206951758516047635e+00
2.513274122871834645e-02 1.205585037553673411e+00
3.141592653589793394e-02 1.203840068169563127e+00
3.769911184307751795e-02 1.201725874483989820e+00
4.398229715025710196e-02 1.199253312231516322e+00
5.026548245743669291e-02 1.196434967546847306e+00
~~~
{: .output}

A Python file is already provided to compute the [discrete Fourier
transform](https://en.wikipedia.org/wiki/Discrete_Fourier_transform) of
these data, and may be viewed carefully with `nano` or safely with
the read-only pager `less`. The python file requires several modules
including `numpy` and `pylab`, which are not accessible without
appropriately modifying our environment. To demonstrate this, output the
`$PATH` environment variable:

~~~
$ echo $PATH
$ which python
~~~
{: .language-bash}

~~~
/usr/lib64/qt-3.3/bin:/home/rcjdoeuser/perl5/bin:/packages/scripts:/packages/sysadmin/agave/scripts/:/usr/local/cuda/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/packages/7x/perl5lib/bin:/home/rcjdoeuser/.local/bin:/home/rcjdoeuser/bin

/bin/python
~~~
{: .output}

Note that this **environment variable** contains directories delimited
by a colon character. These are the directories, or **paths**, that the
shell searches for executables when given a command to run. That is, in
the above example, the shell looks for an executable called `echo` first
in `/usr/lib64/qt-3.3/bin` before checking `/usr/local/bin`, where it is
first found. Python exists as an executable by default on Linux systems,
as it is useful and often used for system administration. By running
`which python`, the first instance of `python` as an executable within
the specified `$PATH` is shown: `bin/python`. However, on Agave, the
correct **module** file has to be loaded to properly set up the shell
environment to access the correct scientific python. That is,

~~~
$ module load anaconda/py3
$ echo $PATH
$ which python
~~~
{: .language-bash}

~~~
##############################################                                  
INFORMATION                                                                     
##############################################                                  
                                                                                
You have loaded the base anaconda environment. For specialized environments,    
you must first enable them with `source activate [env]`.                        
                                                                                
For a full list of environments, type `conda env list`     

/packages/7x/anaconda3/5.3.0/bin:/usr/lib64/qt-3.3/bin:/home/rcjdoeuser/perl5/bin:/packages/scripts:/packages/sysadmin/agave/scripts/:/usr/local/cuda/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/packages/7x/perl5lib/bin:/home/rcjdoeuser/.local/bin:/home/rcjdoeuser/bin

/packages/7x/anaconda3/5.3.0/bin/python
~~~
{: .output}

When the `anaconda/py3` module is loaded, amongst other background processes,
the environment `$PATH` is updated so that the correct scientific python
executable and its libraries are found by the shell first:
`/packages/7x/anaconda3/5.3.0/bin/python`.

> ## Module Environments
>
> Before beginning any scientific workflow, it is recommended to run, 
> `module purge` to reset your environment and prevent any nasty dependency
> clashes. Additionally, to see a list of loaded modules, use `module list`. To
> see all modules available on Agave, use `module avail` or refine your search
> to the software you are interested in by adding it as an additional argument,
> e.g. `module avail matlab`.
{: .callout}

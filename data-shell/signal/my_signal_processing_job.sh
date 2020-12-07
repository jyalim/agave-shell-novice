#!/bin/bash
#SBATCH -p debug 
#SBATCH -q wildfire
#SBATCH -t 5
#SBATCH -c 1
#SBATCH -e signal_processing_job.%j.err
#SBATCH -o signal_processing_job.%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=%u+agave+sbatch@email.asu.edu

# Grab node information if desired (note a lot of this is recorded by
# slurm already)
echo hostname: $(hostname)
echo    nproc: $(nproc)
echo     free: $(free -h)
echo      pwd: $(pwd)
# Purge any loaded modules to ensure consistent working environment
module purge
# Load required software
module load anaconda/py3
# Diagnostic information
module list
which python
# Put bash into a diagnostic mode that prints commands
set -x
# Starting
echo STARTED: $(date)
# Run scientific workflow
python get_fft.py
# Send output figure to researcher email
mail -a fft.png -s "fft complete" "${USER}+agave+batchjob@email.asu.edu" <<< "SEE ATTACHED"
# Finished
echo FINISHED: $(date)

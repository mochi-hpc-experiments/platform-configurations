#!/bin/sh
#PBS -l select=2
#PBS -l place=scatter
#PBS -l walltime=0:10:00
#PBS -l filesystems=home
#PBS -q debug
#PBS -A CSC250STDM12

set -eu

# Change to working directory
cd ${PBS_O_WORKDIR}

echo "Setting up spack"
source $HOME/working/src/spack/share/spack/setup-env.sh
echo "Activating env"
spack env activate polaris-demo
spack find -fN

# IMPORANT NOTE: the --cpu-bind depth option to mpiexec is crucial if you
# intend to run Mochi processes that will use additional threads or
# execution streams.  The default CPU binding on Polaris will limit each
# process launched with mpiexec to a single CPU core that will starve any
# additional threads.
mpiexec -n 2 --ppn 1 --cpu-bind none /home/carns/working/install-polaris/bin/margo-p2p-bw -x 8388608 -n "cxi://" -c 8 -D 20


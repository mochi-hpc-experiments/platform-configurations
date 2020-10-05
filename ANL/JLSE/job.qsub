#!/bin/bash
#COBALT -n 2
#COBALT -t 1:00:00
#COBALT --mode script
#COBALT -q it 

set -eu

echo "Setting up environment modules"
module use /soft/modulefiles
module load spack/linux-rhel7-x86_64
module load gcc/develop-gcc-9.3.0-42htf6e
module load intelmpi/2019-gcc

echo "Setting up spack"
source $HOME/spack/share/spack/setup-env.sh # XXX change this
spack env activate myenv # XXX change this

echo "Starting benchmark"

time mpirun -np 2 -f ${COBALT_NODEFILE} ...

echo "Done!"

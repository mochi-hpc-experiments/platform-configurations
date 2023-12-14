#!/bin/bash
#SBATCH -A m888
#SBATCH -C cpu
#SBATCH -q regular
#SBATCH -t 10:00
#SBATCH -n 2
#SBATCH --ntasks-per-node=1

# load your spack environment
. /global/homes/p/pcarns/working/src/spack/share/spack/setup-env.sh
spack env activate perlmutter-demo
# confirm what packages are available
spack find -vN

srun -n 2 /global/homes/p/pcarns/working/install-perlmutter/bin/margo-p2p-bw -x 8388608 -n "cxi://" -c 8 -D 20

#!/bin/bash
#SBATCH -A m888_g
#SBATCH -C gpu
#SBATCH -q regular
#SBATCH -t 10:00
#SBATCH -n 2
#SBATCH --ntasks-per-node=1

# load your spack environment
. /global/homes/p/pcarns/working/src/spack/share/spack/setup-env.sh
spack env activate perlmutter-demo
# confirm what packages are available
spack find -vN

# NOTE: Perlmutter Phase 1 uses Slingshot 10 and the verbs:// transport.
srun -n 2 /global/homes/p/pcarns/working/install-perlmutter/bin/margo-p2p-bw -x 8388608 -n "verbs://" -c 8 -D 20

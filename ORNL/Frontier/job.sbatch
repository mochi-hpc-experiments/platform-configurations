#!/bin/bash
#SBATCH -A CSC300
#SBATCH -J margo-p2p-bw
#SBATCH -o %x-%j.out
#SBATCH -t 00:15:00
#SBATCH -p batch
#SBATCH -q debug
#SBATCH -N 2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=carns@mcs.anl.gov

# load your spack environment
. /ccs/home/carns/working/src/spack/share/spack/setup-env.sh
spack env activate frontier-demo
# confirm what packages are available
spack find -vN

# NOTE: by using cxi:// as the address string without specifying which NIC
# to use, we are allowing Mercury to select the one closest to the process
# in terms of bus locality.  Frontier has 4 NICs per node that are each
# conneted to the same fabric.
srun -n 2 --ntasks-per-node=1 /ccs/home/carns/working/install-frontier/bin/margo-p2p-bw -x 8388608 -n "cxi://" -c 8 -D 20

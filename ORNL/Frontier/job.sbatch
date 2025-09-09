#!/bin/bash
#SBATCH -A CSC617
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

# These two options request that a) SLURM allocate a VNI that spans across
# the job allocation (not just this mpiexec invocation) and b) that it
# allocate VNI resources even if it detects that all of the processes
# launched by a given mpiexec command are on the same node.  This is
# important for use cases where Mochi servers or clients are started
# individually.
VNI_OPTS="--network job_vni,single_node_vni"

# Note that Margo versions 0.21.0 or later will automatically select an
# appropriate network card from those available on each node.  You could
# also explicitly select a specific card by using a format like
# "cxi://cxi0".
ADDRESS="cxi://"

srun -n 2 --ntasks-per-node=1 ${VNI_OPTS} /ccs/home/carns/working/install-frontier/bin/margo-p2p-bw -x 8388608 -n ${ADDRESS} -c 8 -D 20

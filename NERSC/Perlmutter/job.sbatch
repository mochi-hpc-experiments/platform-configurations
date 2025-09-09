#!/bin/bash
#SBATCH -A m888
#SBATCH -C cpu
#SBATCH -q debug
#SBATCH -t 10:00
#SBATCH -n 2
#SBATCH --ntasks-per-node=1

# load your spack environment
. /global/homes/p/pcarns/working/src/spack/share/spack/setup-env.sh
spack env activate perlmutter-demo
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


srun -n 2 --ntasks-per-node=1 ${VNI_OPTS} /global/homes/p/pcarns/working/install-perlmutter/bin/margo-p2p-bw -x 8388608 -n ${ADDRESS} -c 8 -D 20

#!/bin/bash
#COBALT -A MY_PROJECT
#COBALT -n 4
#COBALT -t 0:30:00
#COBALT --mode script

set -eu

# note: disable registration cache for verbs provider for now; see
#       discussion in https://github.com/ofiwg/libfabric/issues/5244
export FI_MR_CACHE_MAX_COUNT=0
# use shared recv context in RXM; should improve scalability
export FI_OFI_RXM_USE_SRX=1

echo "Setting up spack"
source $HOME/spack/share/spack/setup-env.sh
echo "Activating env"
spack env activate myenv

echo "Starting up application"
mpirun -f $COBALT_NODEFILE -n 4 ...

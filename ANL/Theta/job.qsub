#!/bin/bash
#COBALT -A MY_PROJECT
#COBALT -n 4
#COBALT -t 0:30:00
#COBALT --mode script
#COBALT -q debug-flat-quad

set -eu

# prevents interference between MPI and Mochi (libfabric) libraries
# when sharing GNI resources
export MPICH_GNI_NDREG_ENTRIES=1024

PDOMAIN=mypdomain

echo "Setting up spack"
source $HOME/spack/share/spack/setup-env.sh
echo "Activating env"
spack env activate myenv

echo "Setting up protection domain"
apstat -P | grep ${PDOMAIN} || apmgr pdomain -c -u ${PDOMAIN}

echo "Starting up application"
aprun -n 4 -N 2 -cc none -d 32 -p ${PDOMAIN} ... 

echo "Destroying protection domain"
apmgr pdomain -r -u ${PDOMAIN}

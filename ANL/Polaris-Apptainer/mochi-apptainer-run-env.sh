module use /soft/spack/gcc/0.6.1/install/modulefiles/Core
module load apptainer
module load cray-mpich-abi

export HTTP_PROXY=http://proxy.alcf.anl.gov:3128
export HTTPS_PROXY=http://proxy.alcf.anl.gov:3128
export http_proxy=http://proxy.alcf.anl.gov:3128
export https_proxy=http://proxy.alcf.anl.gov:3128

export APPTAINER_BIND="/opt:/opt,/usr:/host-usr"
# if the palsd directory is present (i.e., the container is executed on a
# compute node) then we should bind that path as well for the job launcher
if [ -d "/var/run/palsd" ]; then
    export APPTAINER_BIND="$APPTAINER_BIND,/var/run/palsd:/var/run/palsd"
fi

PALS_PATH=/opt/cray/pals/1.3.4/lib
OFI_PATH=/opt/cray/libfabric/1.15.2.0/lib64
JSONC_PATH=/host-usr/lib64

export APPTAINERENV_LD_LIBRARY_PATH="$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH:$PALS_PATH:$OFI_PATH:$JSONC_PATH"
# TODO: fix this; see spack options
export APPTAINERENV_LD_PRELOAD="/opt/cray/libfabric/1.15.2.0/lib64/libfabric.so.1:/opt/cray/pe/mpich/8.1.28/ofi/nvidia/23.3/lib-abi-mpich/libmpi.so.12"


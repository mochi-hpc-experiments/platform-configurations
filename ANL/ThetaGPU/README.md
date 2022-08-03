ThetaGPU
========


Programming environment
-----------------------

We recommend using the default gcc, OpenMPI, and OFED packages on ThetaGPU
as specified in the provided spack.yaml file.  Note that you must use an
interactive allocation on ThetaGPU to compile code for ThetaGPU; it cannot
be done on the login nodes.  Here is an example of how to get an interactive
node for 1 hour:

```
module load cobalt/cobalt-gpu
qsub -I -n 1 -t 60 -A radix-io -M carns@mcs.anl.gov -q single-gpu
# set up spack environment
```

Networking
----------

ThetaGPU uses an InfiniBand network.  The corresponding transport in Mercury
is `verbs://`, using the `fabrics=rxm,verbs` variant in the libfabric package.

The `FI_MR_CACHE_MAX_COUNT` environment variable should be set to 0 to
disable the memory registration cache in the verbs provider; it has been
problematic in some libfabric releases.

The `FI_OFI_RXM_USE_SRX` envrionment variable should be set to 1 to enable
shared receive contexts; this is expected to improve scalability.

Job management
--------------

Theta uses the Cobalt workload manager. `job.qsub` is an example
of job file. Please modify the header (lines starting with `#COBALT`)
to use your project allocation and set relevant parameters. You can
refer to ALCF documentation for more information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```


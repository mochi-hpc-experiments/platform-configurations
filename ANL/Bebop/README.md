Bebop
=====


Programming environment
-----------------------

Before using Spack to compile Mochi on Bebop, we recommend the following
changes to your environment:

- `module load gcc`
  - this will change the default compiler from Intel (icc) to GNU (gcc) and
    load a matching Intel MPI library.  We recommend compiling Mochi packages
    using gcc
- `module load intel-mpi`
  - this will insure that the MPI module is reactivated after loading gcc

Networking
----------

Bebop uses an Intel OmniPath fabric. We recommend using the "ofi+psm2"
transport, which utilized the psm2 provider in libfabric for communication.
An alternative is also available in the form of Mercury's own internal psm2
abstraction that can be accessed via the "psm2+psm2" transport.

The `PSM2_MULTI_EP` environment variable should be set to 1 in your job script
to avoid conflict between MPI and Mercury when using the PSM2 network.

The `FI_PSM2_DISCONNECT` environment variable should be set to 1 if you plan
to have distinct Mercury applications dictonnect and reconnect to each other
(e.g. if you have a long running data service on a set of nodes and a set
of applications deployed one after the other on the rest of the nodes, and using
the service).


Job management
--------------

Bebop uses the Slurm workload manager. `job.sbatch` is an example
of job file. Please modify the header (lines starting with `#SBATCH`)
to use your project allocation and set relevant parameters. You can
refer to [the documentation here](https://www.lcrc.anl.gov/systems/resources/bebop/)
for more information on how to configure such a job script.

Once modified, the job script may be submitted as follows.

```
$ sbatch ./job.sbatch
```

Note that the job script explicitly multiple PSM2 environment variables that
are necessary for Mochi compatibility.  Please copy these environment
variables to any other Mochi job scripts that you create for the Bebop platform.

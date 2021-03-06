Bebop
=====


Programming environment
-----------------------

The Bebop machine has many compilers and MPI implementations, not all
of which work correctly with Mochi. We have found `gcc@8.2.0` with
the `intel-mpi` package to be the most reliable way of working with
Mochi on this platform. You can work with these packages by typping:

```
$ module load gcc/8.2.0-g7hppkz
```

This command will automatically change the compiler to `gcc@8.2.0`
and change the `intel-mpi` package to the appropriate one.


Networking
----------

Bebop uses an Intel Omnipath fabric. The corresponding transport in
Mercury is `ofi+psm2`, using the `+psm2` variant in `libfabric`.

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

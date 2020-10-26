Theta
=====


Programming environment
-----------------------

Theta has many compilers and MPI implementations, not all
of which work correctly with Mochi. We found multiple version of gcc that
work with Mochi, and the provided `spack.yaml` file uses the latest version
(`gcc@9.3.0`) with the `cray-mpich` package. You can work with these packages
by typping:

```
$ module swap PrgEnv-intel PrgEnv-gnu
$ module load gcc/9.3.0
```

You may also want to `export CRAYPE_LINK_TYPE=dynamic` (e.g. in your
`.bashrc` file) to prevent the compiler from attempting to use static
linking in conjunction with the dynamic libraries produced by Spack.


Networking
----------

Theta uses a Cray Aries fabric. The corresponding transport in
Mercury is `ofi+gni`, using the `+gni` variant in `libfabric`.


Job management
--------------

Theta uses the Cobalt workload manager. `job.qsub` is an example
of job file. Please modify the header (lines starting with `#COBALT`)
to use your project allocation and set relevant parameters. You can
refer to [the documentation here](https://www.alcf.anl.gov/support-center/theta/submit-job-theta)
for more information on how to configure such a job script.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```

Note the use of a protection domain (pdomain).  Shared protection domains
enable processes to communicate with each other even when launched with
separate `aprun` commands.  Protection domains are global, but user-specific
(i.e. you won't be able to use a pdomain setup by someone else, and you
won't be able to use the same name as someone else's pdomain). There is
a limited number of pdomains that can exist simultaneously, and they are
not cleaned up when your job terminates, so please make sure to delete
your pdomain at the end of your job.

Note that other Cray systems may use `DRC (Dynamic RDMA Credentials)` rather
than static protection domains for this purpose.  The protection domain
configuration in this example is specific to the Theta system.

The `MPICH_GNI_NDREG_ENTRIES` environment variable should be set
to avoid conflicts between MPI and libfabric.

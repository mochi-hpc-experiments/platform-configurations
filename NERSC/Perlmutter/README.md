Perlmutter
==========

NOTE: these instructions are for Perlmutter Phase 1, as of May 8 2022

Programming environment
-----------------------


The example provided in this repository uses the gcc 11.2 compiler.  Load
it using the following command before activating your environment:

```
$ module swap PrgEnv-cray PrgEnv-gnu
```

Networking
----------

Perlmutter Phase 1 is equipped with a Slingshot 10 fabric that uses the
`verbs://` transport. This will eventually be upgraded to Slingshot 11, at
which point the spack.yaml will need to be updated to reference the correct
libfabric build so that the native `cxi://` transport can be used.

Note that we highly recommend using the vendor-provided libfabric library on
Perlmutter rather than building one from scratch in Spack. The latter
approach is not likely to be compatible with the MPI build on Perlmutter.

Job management
--------------

Perlmutter uses slurm for scheduling and job management.

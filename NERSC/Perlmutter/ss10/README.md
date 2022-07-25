Perlmutter
==========

NOTE: these instructions are for Perlmutter nodes with ss10 as of July 2022.
Please see up-to-date NERSC user documentation for the latest status of
which nodes are equipped with ss10 network hardware.

Programming environment
-----------------------

The example provided in this repository uses the gcc 11.2 compiler.  Load
it using the following command before activating your environment:

```
$ module swap PrgEnv-cray PrgEnv-gnu
```

The environment may be compiled on a Perlmutter login node as of July 2022
or a ss10-equiped compute node.

Networking
----------

The Perlmutter nodes equipped with a Slingshot 10 fabric (which will
eventually be updated to Slingshot 11) use the `verbs://` transport.

Note that we highly recommend using the vendor-provided libfabric library on
Perlmutter rather than building one from scratch in Spack. The latter
approach is not likely to be compatible with the MPI build on Perlmutter.

Job management
--------------

Perlmutter uses slurm for scheduling and job management.

Limitations
-----------

As of July 24, 2022, we get communication timeout failures (or hangs) when
attempting communication to one process from more than 32 peers.  The reason
is currently unknown, and appears to be Perlmutter-specific.


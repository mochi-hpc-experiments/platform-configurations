Perlmutter
==========

NOTE: these instructions are for Perlmutter nodes with ss11 as of July 2022.
Please see up-to-date NERSC user documentation for the latest status of
which nodes are equipped with ss11 network hardware.

Programming environment
-----------------------

The example provided in this repository uses the gcc 11.2 compiler.  Load
it using the following command before activating your environment:

```
$ module swap PrgEnv-cray PrgEnv-gnu
```

IMPORTANT: As of July 2022, only the compute nodes equiped withi ss11
hardware have the appropriate libfabric library installed for use with ss11.
This means that you cannot compile code for ss11 on the login nodes.  One
solution is to allocate an ss11 node in interactive mode and set up your
spack environment (and compile your application) there.

Networking
----------

The Perlmutter nodes equipped with a Slingshot 11 fabric use the `cxi://`
transport.

Note that we highly recommend using the vendor-provided libfabric library on
Perlmutter rather than building one from scratch in Spack. The latter
approach is not likely to be compatible with the MPI build on Perlmutter.

Job management
--------------

Perlmutter uses slurm for scheduling and job management.

Limitations
-----------

As of July 24, 2022, it is not possible to launch more than 126 processes
per node that use both MPI and Mochi (the CPU nodes have 128 cores, so in
theory 128 should work).  If more processes than that are launched on a
single node then it produces an error message like the following with
libfabric warnings enabled:

```
libfabric:188579:1658700253:cxi:domain:cxip_alloc_lni():209<warn> nid005477: Failed to allocate LNI, ret: -28
libfabric:188579:1658700253:cxi:domain:cxip_domain_enable():48<warn> nid005477: cxip_alloc_lni returned: -28
libfabric:188579:1658700253:cxi:domain:cxip_domain():919<warn> nid005477: Resource allocation failed: -19: No such device
[error] Could not initialize hg_class
Error: failed to initialize margo with ofi+cxi protocol.
```

Also note that at this time, the ss11 software will busy spin to poll for
new messages (i.e., there is not blocking communication support).  This
feature is expected in an upcoming software release.

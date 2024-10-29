Frontier
========


Programming environment
-----------------------

The example provided in this repository uses the gcc 12.3 compiler.  Load
it using the following command before activating your environment:

```
$ module swap PrgEnv-cray PrgEnv-gnu
```

Networking
----------

Mercury should use the `cxi` transport method in Mercury in order to utilize
the native Cray Slingshot network interface.  If you use "cxi://" as the
initialization string without specifying a specific NIC, then Mercury will
select the one that is "closest" to the process in terms of bus locality.

Each Frontier compute node has 4 NICs (see OLCF documentation).
can be selected manually by using a specification of the form "cxi://cxi0".

It is important to use the vendor-provided libfabric library available in
the default software environment rather than compiling one with Spack in
order to have full Slingshot network support.

Job management
--------------

Frontier uses slurm for scheduling and job management.  See the `job.slurm`
script in this directory for an example.

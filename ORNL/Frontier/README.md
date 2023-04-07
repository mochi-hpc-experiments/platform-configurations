Frontier
========


Programming environment
-----------------------

The example provided in this repository uses the gcc 12.2 compiler.  Load
it using the following command before activating your environment:

```
$ module swap PrgEnv-cray PrgEnv-gnu
```

In principle it should also be possible to compile the Mochi stack using the
default PrgEnv-cray compilers (based on Clang).  If that configuration is
desired then you will need to modify the spack.yaml file to refer to that
compiler.

Package versions
----------------

Note that the Frontier spack environment pins some packages to specific
versions as of 2022-04-07:

- mercury@master: As of 2023-04-07 it is recommended to use the latest Mercury
  revision from origin/main for the most up-to-date Slingshot (CXI) feature
  support.  2.2.0 should work, but will lack some optimizations and may
  exhibit excessive CPU usage.

Networking
----------

Mercury should use the `cxi` transport method in Mercury in order to utilize
the native Cray Slingshot network interface.  If you use "cxi://" as the
initialization string without specifying a specific NIC, then Mercury will
select the one that is "closest" to the process in terms of bus locality.

Each Frontier compute node has 4 NICs (see OLCF documentation).
can be selected manually by using a specification of the form "cxi://cxi0".

Frontier uses libfabric as its network abstraction layer.  It is important to
use the vendor-provided libfabric library available in the default software
environment rather than compiling one with Spack, however, in order to have
full Slingshot network support as of 2023-04-07.

Job management
--------------

Frontier uses slurm for scheduling and job management.  See the Frontier
documentation for details.  The example given in this directory runs one
process per compute node, but many other configurations are possible as
well.

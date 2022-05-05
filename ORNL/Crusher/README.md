Crusher
=======


Programming environment
-----------------------

The example provided in this repository uses the gcc 11.2 compiler.  Load
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

Note that the Crusher spack environment pins some packages to specific
versions as of 2022-05-06:

- json-c@0.13.1: This is chosen for compatibility with the 0.13 json-c
  library used by Crusher's vendor-provided libfabric build as of
  2022-05-06.  It would be preferable to use the system's json-c library
  instead, but we need to have the libjson-c-devel rpm installed on the
  Crusher login nodes in order to compile against it. See OLCFHELP-7157
  ticket.
- mercury@2.2.0rc1: As of 2022-05-06 it is necessary to use a Mercury
  release candidate to pick up support for the Slingshot (CXI) network
  transport.  This constraint can be removed once there the final 2.2.0
  release is available.

Networking
----------

Mercury should use the `cxi` transport method in Mercury in order to utilize
the native Cray Slingshot network interface.  If you use "cxi://" as the
initialization string without specifying a specific NIC, then Mercury will
select the one that is "closest" to the process in terms of bus locality.

Each Crusher compute node has 4 NICs (see
https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html).  They
can be selected manually by using a specification of the form "cxi://cxi0".

Crusher uses libfabric as its network abstraction layer.  It is important to
use the vendor-provided libfabric library available in the default software
environment rather than compiling one with Spack, however, in order to have
full Slingshot network support as of 2022-05-06.

Job management
--------------

Crusher uses slurm for scheduling and job management.  See the Crusher
documentation for details.  The example given in this directory runs one
process per compute node, but many other configurations are possible as
well.

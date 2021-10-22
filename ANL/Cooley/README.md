Cooley
=====


Programming environment
-----------------------

Before using Spack to compile Mochi on Cooley, we recommend the following
changes to your environment to get access to newer gcc, cmake, and mvapich
versions:

- `soft add +gcc-8.2.0`
- `soft add +cmake-3.20.4`
- `soft add +mvapich2`

Networking
----------

Cooley uses an InfinBand network fabric. The corresponding transport in
Mercury is `ofi+verbs`, using the `fabrics=verbs,rxm` variant in the
`libfabric` Spack package.

The `FI_MR_CACHE_MAX_COUNT` environment variable should be set to 0 to
disable the memory registration cache in the verbs provider; it has been
problematic in some libfabric releases.

The `FI_OFI_RXM_USE_SRX` envrionment variable should be set to 1 to enable
shared receive contexts; this is expected to improve scalability.

Job management
--------------

Cooley uses the Cobalt workload manager.

TODO: fill in details and example job script.

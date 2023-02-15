Polaris
=======


Programming environment
-----------------------

Note that this documentation is for Polaris while using the Slingshot 10
fabric.  This will need to be updated at some point in the future after the
planned upgrade to Slingshot 11.

We recommend using the system-provided GNU compiler as specified in the
example spack configurations.  The GNU compiler can also be loaded in
your normal terminal environment (outside of Spack) by running `module
swap PrgEnv-nvphc PrgEnv-gnu`.  It may also be necessary to run `module
load cudatoolkit-standalone` once the PrgEnv modules have been swapped.

Networking
----------

Polaris will use the `ofi+verbs://` transport in Mercury while it is equipped
with a Slingshot 10 network.  The default environment includes a libfabric
package that is already properly configured to use it.

Note that the default configuration provided here in spack.yaml will replace
the vendor-provided libfabric communication library with the upstream
libfabric 1.17.0.  In our experience, this resolves RPC timeout errors and
`Unsupported CQ event` errors that may occur in some configurations.  It is
not validated/supported by HPE however, and it also replaces the libfabric
version that MPICH will use for MPI communication.  See the "vendor-provided
libfabric" configuration below if you prefer to use the sytem libfabric
library or find that the upstream version is lacking functionality.

This build still uses the vendor-provided MOFED, CUDA, and MPICH libraries.

The `FI_MR_CACHE_MAX_COUNT` environment variable should be set to 0 to
disable the memory registration cache in the verbs provider; it has been
problematic in some libfabric releases.

The `FI_OFI_RXM_USE_SRX` envrionment variable should be set to 1 to enable
shared receive contexts; this is expected to improve scalability.

Alternative network configuration: vendor-provided libfabric
------------------------------------------------------------

The `spack-system-libfabric.yaml` file specifies an alternative Spack
environment configuration in which Mochi uses the vendor-provided libfabric
package rather than compiling a new upstream version.  See discussion in
previous section for why this is not the recommended default configuration.

When using this spack environment configuration, please add the following
environment variable to avoid potential RPC timeout errors at scale:

`export FI_VERBS_PREFER_XRC=0`

Alternative network configuration: UCX
--------------------------------------

The `spack-ucx.yaml` file specifies an alternative Spack environment
configuration in which the Mochi stack is built with support for both
libfabric _and_ UCX network transports.  You can activate the UCX/verbs
transport by using the `ucx+all://` address specifier in place of
`ofi+verbs://` at runtime when initializing Thallium, Margo, or Mercury.

The UCX networking option is feature-complete but not as well tested as
libfabric at this time.  See `job-ucx.qsub` for an example of how to run a
job that uses the UCX transport.

Job management
--------------

Polaris uses the PBS Pro workload manager.  `job.qsub` is an example of job
file. Please modify the header to use your project allocation and set
relevant parameters. You can refer to ALCF documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```


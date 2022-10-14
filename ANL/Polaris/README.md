Polaris
=======


Programming environment
-----------------------

Note that this documentation is for Polaris while using the Slingshot 10
fabric.  This will need to be updated at some point in the future after the
planned upgrade to Slingshot 11.

We recommend using the system-provided GNU compiler and libfabric library on
Polaris specified in the provided spack.yaml file.

The GNU compiler can also be loaded in your normal terminal environment
(outside of Spack) by running `module swap PrgEnv-nvphc PrgEnv-gnu`.

Networking
----------

Polaris will use the `ofi+verbs://` transport in Mercury while it is equipped
with a Slingshot 10 network.  The default environment includes a libfabric
package that is already properly configured to use it.

The `FI_MR_CACHE_MAX_COUNT` environment variable should be set to 0 to
disable the memory registration cache in the verbs provider; it has been
problematic in some libfabric releases.

The `FI_OFI_RXM_USE_SRX` envrionment variable should be set to 1 to enable
shared receive contexts; this is expected to improve scalability.

Alternative networking: UCX
---------------------------

The `spack-ucx.yaml` file specifies an alternative Spack environment
configuration in which the Mochi stack is built with support for both
libfabric _and_ UCX network transports.  You can activate the UCX/verbs
transport by using the `ucx+all://` address specifier in place of
`ofi+verbs://` at runtime when initializing Thallium, Margo, or Mercury.

The UCX networking option is feature-complete but not as well tested as
libfabric at this time.

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


Polaris
=======


Programming environment
-----------------------

We recommend using the system-provided GNU compiler as specified in the
example spack configurations.  The GNU compiler can also be loaded in
your normal terminal environment (outside of Spack) by running `module
swap PrgEnv-nvidia PrgEnv-gnu`.

Networking
----------

Polaris will use the `ofi+cxi://` transport in Mercury for native access to
the Slingshot network. The default environment includes a libfabric package
that is already properly configured to use it.  Note that this is only
available using the system libfabric libraries on Polaris; CXI (Slingshot)
support is not available in the upstream open source libfabric package.

This Spack environment also relies on system CUDA and Cray MPICH libraries.

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

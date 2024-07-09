Polaris
=======


Programming environment
-----------------------

We recommend using the system-provided GNU compiler as specified in the
example spack configurations.  The GNU compiler can also be loaded in
your normal terminal environment (outside of Spack) by running `module
swap PrgEnv-nvhpc PrgEnv-gnu`.  You should also run `module
load nvhpc-mixed` to gain access to CUDA libraries that may be
required for executables built within this Spack environment.

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

Notes
-----
As of this writing (2024-07-09) it is best to use json-c 0.13 with Mochi in
order to ensure link time compatibility with the system json-c used by the
system libfabric and cray-mpich on Polaris.  This spack.yaml example uses a
`require:` directective to enforce this constraint.  Note that json-c 0.13 is
not available upstream in spack; it is provided as part of the
mochi-spack-packages repository.

These instructions and environment examples will be updated if a matching
json-c-devel package is installed on Polaris (in which case we can use it as an
external package) or the system-provided libfabric package is built against a
newer version of json-c (in which case Mochi will be able to use a newer json-c
as well).

Polaris
=======


Programming environment
-----------------------

We recommend using the system-provided GNU compiler as specified in the
example spack configurations.  The GNU compiler can also be loaded in
your normal terminal environment (outside of Spack) by running `module
swap PrgEnv-nvhpc PrgEnv-gnu`.  You should also run `module
load cudatoolkit-standalone` to gain access to CUDA libraries that may be
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
As of this writing (2023-12-4) it is best to use json-c 0.13 with Mochi in
order to ensure link time compatibility with the system json-c used by the
system libfabric and cray-mpich on Polaris. However, the json-c-devel
package is not installed on Polaris at this time, and 0.13 is not available
in upstream Spack, so this is a difficult combination to use for Mochi.

As a workaround, the mochi-spack-packages repo adds an additional json-c
version (labeled 0.13.0 to disambiguate from 0.13.1 which is already in
Spack).  We also add a dependency in the root spec in the spack.yaml to
ensure that this version is used on Polaris.

These instructions and environment examples will be updated if/when a
matching json-c-devel package is installed on Polaris in the system
environment.

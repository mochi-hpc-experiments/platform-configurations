Polaris
=======


Programming environment
-----------------------

We recommend using the system-provided GNU compiler as specified in the
example Spack configuration.  Load it in your normal terminal environment
before activating the environment with the following command:

```
module swap PrgEnv-nvidia PrgEnv-gnu
```

Networking
----------

Polaris will use the `ofi+cxi://` transport in Mercury for native access to
the Slingshot network. We recommend using the system-provided modules for
both libfabric and MPICH.

Job management
--------------

Polaris uses the PBS Pro workload manager.  See `job.qsub` for an example
job script. Please modify the header to use your project allocation and set
relevant parameters. You can refer to ALCF documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```

Notes on Slingshot network usage
--------------------------------

Mochi cannot activate the Slingshot network on Polaris unless the resource
manager allocates a VNI (virtual network interface) for it to use.  We
therefore recommend the following; see job.qsub for a concrete example:
* All processes (even if they are to be executed on the local node in a
  script) must be launched using `mpiexec`.
* Use the `--single-node-vni` option to mpiexec to ensure that it allocates
  a VNI in all cases.
* Set the `PALS_LOCAL_LAUNCH=0` environment variable to work around a PALS
  bug that prevents the above option from working correctly for processes
  launched on the local node.
* Use mochi-margo version 0.21.0 or later for improved VNI handling and
  better load balancing of traffic across available network cards.

The above recommendations will enable all processes launched within a given
job allocation to communicate with each other, whether they are launched
simultaneously with one `mpiexec` command or lauched separately with
distinct `mpiexec` commands.

There is no mechanism to communicate *across* separate job allocations at
this time.  This functionality would require configuration and deployment of
the `drc2` service by the facility/vendor.

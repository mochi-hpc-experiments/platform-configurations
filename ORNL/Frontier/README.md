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

Frontier will use the `ofi+cxi://` transport in Mercury for native access to
the Slingshot network. We recommend using the system-provided modules for
both libfabric and MPICH.

Job management
--------------

Frontier uses SLURM for scheduling and job management.  See `job.sbatch` for
an example job script.  Please modify the header to use your project
allocation and set relevant parameters. You can refer to OLCF documentation
for more information.

Once modified, the job script may be submitted as follows.

```
$ sbatch job.sbatch
```

Notes on Slingshot network usage
--------------------------------

Mochi cannot activate the Slingshot network on Frontier unless the resource
manager allocates a VNI (virtual network interface) for it to use.  We
therefore recommend the following; see job.slurm for a concrete example:
* All processes (even if they are to be executed on the local node in a
  script) must be launched using `srun`.
* Use the `--nework job_vni,single_node_vni` option to `srun` to ensure that
  it allocates a job level VNI in all cases.
* Use mochi-margo version 0.21.0 or later for improved VNI handling and
  better load balancing of traffic across available network cards.

The above recommendations will enable all processes launched within a given
job allocation to communicate with each other, whether they are launched
simultaneously with one `srun` command or lauched separately with
distinct `srun` commands.

There is no mechanism to communicate *across* separate job allocations at
this time.  This functionality would require configuration and deployment of
the `drc2` service by the facility/vendor.

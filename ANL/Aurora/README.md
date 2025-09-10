Aurora
======


Programming environment
-----------------------

We recommend using the system-provided GNU compiler as specified in the
example Spack configurations.

Networking
----------

Polaris will use the `ofi+cxi://` transport in Mercury for native access to
the Slingshot network. We recommend using the system-provided modules for
both libfabric and MPICH.

Process placement
-----------------

Aurora nodes have 2 sockets, each with 52 cores, however core 0 and core 52
are reserved to run service processes. Hence, 102 cores are available
in total.  See the man page for `mpiexec` for common process binding
options.

You can also use the `make-cpu-bind-list.sh` script in this directory to
generate an explicit binding list for a desired number of processes.  For
instance `./make-cpu-bind-list.sh 8` will generate a core mapping for 8
ranks. 4 will be placed on each socket, and each rank will be mapped to as
many cores as possible.

Note that the list will also contain numbers greater than 104; this is
because the list actually maps ranks to hyperthreads, with core `n`
containing hyperthreads `n` and `n+104`.

Job management
--------------

Aurora uses the PBS Pro workload manager.  See `job.pbs` for an example job
script. Please modify the header to use your project allocation and set
relevant parameters. You can refer to ALCF documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.pbs
```

Notes on Slingshot network usage
--------------------------------

Mochi cannot activate the Slingshot network on Aurora unless the resource
manager allocates a VNI (virtual network interface) for it to use.  We
therefore recommend the following; see job.qsub for a concrete example:
* All processes (even if they are to be executed on the local node in a
  script) must be launched using `mpiexec`.
* Use the `--single-node-vni` option to mpiexec to ensure that it allocates
  a VNI in all cases.
* Set the `PALS_LOCAL_LAUNCH=0` to work around a PALS bug that prevents the
  above option from working correctly for processes launched on the local
  node.
* Use mochi-margo version 0.21.0 or later for improved VNI handling and
  better load balancing of traffic across available network cards.

The above recommendations will enable all processes launched within a given
job allocation to communicate with each other, whether they are launched
simultaneously with one `mpiexec` command or lauched separately with
distinct `mpiexec` commands.

Note that as of this writing (September 2025) you also have the option to
use the default system VNI on Aurora, which permits communication between
any processes on the system.  To use this mode, use `--no-vni` rather than
`--single-node-vni` when launching processes with `mpiexec`, or you can
launch processes directly without mpiexec.

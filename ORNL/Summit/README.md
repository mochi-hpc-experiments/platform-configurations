Summit
======


Programming environment
-----------------------

Any version of gcc should be working on Summit. Summit provides the
spectrum-mpi package as MPI implementation. When building source codes,
you should load the relevant gcc as follow:

```
$ module swap xl gcc/9.1.0
```

The `spack.yaml` file in this directory uses gcc 9.1.0.

Networking
----------

Mercury should use the `verbs` transport method in Mercury, which
translates to `ofi+verbs;ofi_rxm` internally.  You must also specify the
libfabric domain when initializing Mercury by using `verbs://mlx5_0`
as the local address. This will ensure that libfabric
uses the correct default port on the network card.

Libfabric should be compiled with the `fabrics=verbs,rxm` variant.  You may
also add `tcp` to the list of fabrics in order to be able to use the TCP
transport in Mercury as well. Note that the `spack.yaml` file in this folder
does not add this variant by default.

Also note that the spack.yaml file is configured to use an external
rdma-core package with libfabric. This is a crucial configuration detail.
If rdma-core is compiled by Spack, it will conflict with the version
used by Spectrum MPI and probably lack some Summit-specific optimizations.

Job management
--------------

Summit uses the lsbatch workload manager. `job.lfs` is an example
of job file. Please modify the header (lines starting with `#BSUB`)
to use your project allocation and set relevant parameters. You can
refer to [the documenattion here](https://docs.olcf.ornl.gov/systems/summit_user_guide.html#running-jobs)
for more information on how to configure such a job script.

Once modified, the job script may be submitted as follows.

```
$ bsub ./job.lfs
```

Job management tips
--------------

* To run the server/provider in one process and client in another, you must disable 'cgroups':  submit your job with `#BSUB -step_cgroup n`
* If you want the server/provider to run on one node and client on another, request multiple nodes with 'bsub' and run with 'jsrun -n 1 -r 1 -g ALL_GPUS'.  You can background one jsrun to start the server and then run another jsrun to start the client

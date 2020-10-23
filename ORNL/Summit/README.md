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
as the local address. This will insure that libfabric
uses the correct default port on the network card.

Libfabric should be compiled with the `+verbs` and `+rxm` variants.

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

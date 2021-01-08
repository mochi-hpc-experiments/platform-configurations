Theta
=====


Programming environment
-----------------------

Cori has many compilers and MPI implementations. We found multiple version of gcc that
work with Mochi, and the provided `spack.yaml` file uses the latest version
(`gcc@9.3.0`) with the `cray-mpich` package. You can work with these packages
by typping:

```
$ module swap PrgEnv-intel PrgEnv-gnu
$ module swap gcc8/.3.0 gcc/9.3.0
```

You may also want to `export CRAYPE_LINK_TYPE=dynamic` (e.g. in your
`.bashrc` file) to prevent the compiler from attempting to use static
linking in conjunction with the dynamic libraries produced by Spack.


Networking
----------

Cori uses a Cray Aries fabric. The corresponding transport in
Mercury is `ofi+gni`, using the `+gni` variant in `libfabric`.


Job management
--------------

TODO

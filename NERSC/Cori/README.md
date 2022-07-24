Cori
====


Programming environment
-----------------------

Cori has many compilers and MPI implementations. We recommend using the
default version of the GNU compilers and cray-mpich as described in the
provided `spack.yaml` file.  The GNU compilers can be loaded as follows:

```
$ module swap PrgEnv-intel PrgEnv-gnu
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

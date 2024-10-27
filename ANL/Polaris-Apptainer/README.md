Polaris Apptainer
=================

This document describes how to build an Apptainer image on Polaris that can
be used to execute Mochi services within a container.

The key issue in this environment is to build a container that contains
general-purpose versions of MPI and libfabric that are ABI-compatible with
the corresponding native implementations on Polaris.  This will allow the
containers to remain portable and generic while still leveraging
platform-native capabilities when executed on Polaris.

Note that on Polaris the vendor-supplied libfabric has additional internal
dependencies, in particular libjson-c, which must also be ABI compatible
with the corresponding libraries used in the Mochi build.

General information about using containers on Polaris can be found at https://docs.alcf.anl.gov/polaris/data-science-workflows/containers/containers/ .

Building an image
-----------------

Allocate a single compute node in interactive mode:

```
qsub -I -A radix-io -q debug -l select=1 -l walltime=60:00 -l singularity_fakeroot=true -l filesystems=home:eagle
```

Set up your environment:

```
source ./mochi-apptainer-build-env.sh
```

Build image:

```
apptainer build --fakeroot mochi-apptainer.sif mochi-apptainer.def
```

Running the container
---------------------

The following instructions assume that you are running the container on a
compute node.

Set up your environment:

```
source ./mochi-apptainer-run-env.sh
```

Execute a shell:

```
apptainer shell mochi-apptainer.sif
```

Validate that the container is working and accessing the high speed
Slingshot network by running `margo-info` and looking for `ofi+cxi:\\` in
the output to see if the network interface has been activiated.

To Do
-----

- The image will likely need to be updated when newer versions of libfabric
  are deployed on Polaris.
- It may be possible to avoid setting `LD_PRELOAD` (and instead just rely on
  `LD_LIBRARY_PATH`) if Spack were configured to set `runpath` rather than
  `rpath` for embedding library paths into libraries and executables.  The
  latter does not take precedence over `LD_LIBRARY_PATH`. See
  https://github.com/spack/spack/pull/9168.
- The container is intended to also be executable on login nodes, but the
  `margo-info` command line tool hangs when executed on a login node.

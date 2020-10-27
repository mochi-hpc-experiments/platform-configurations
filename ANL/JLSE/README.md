JLSE
====

JLSE is not a supercomputer but a set of heterogeneous resources.
The `spack.yaml` file provided here was tested on the It machines
(see the full list of machines [here](https://www.jlse.anl.gov/hardware-under-development/)),
and may not work on other machine types.

Programming environment
-----------------------

As described [here](https://wiki.jlse.anl.gov/display/JLSEdocs/JLSE+Software),
JLSE provides many modules, including some installed using Spack. To use
them you will need to execute the following.

```
module use /soft/modulefiles
module load spack/linux-rhel7-x86_64
```

The provided `spack.yaml` file uses the gcc 9.3.0 compiler along with
the `intel-mpi` implementation of MPI. These packages can be loaded as follows.

```
module load gcc/9.3.0-gcc-9.3.0-qfmcwfb
module load intelmpi/2019-gcc
```

Networking
----------

JLSE machines can use TCP. The corresponding transport in Mercury
is `ofi+tcp`, using the `fabrics=tcp,rxm` variant in libfabric.


Job management
--------------

JLSE uses the Cobalt workload manager.  The provided `job.qsub` script is an
example of job file. Please modify the header (lines starting with
`#COBALT`) to set relevant parameters.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```

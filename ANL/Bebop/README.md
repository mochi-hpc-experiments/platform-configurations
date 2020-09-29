Bebop
=====


Programming environment
-----------------------

The Bebop machine has many compilers and MPI implementations, not all
of which work correctly with Mochi. We have found `gcc@8.2.0` with
the `intel-mpi` package to be the most reliable way of working with
Mochi on this platform. You can work with these packages by typping:

```
$ module load gcc/8.2.0-g7hppkz
```

This command will automatically change the compiler to `gcc@8.2.0`
and change the `intel-mpi` package to the appropriate one.


Networking
----------

Bebop uses an Intel Omnipath fabric. The corresponding transport in
Mercury is `ofi+psm2`, using the `+psm2` variant in `libfabric`.


Job management
--------------

Bebop uses the Slurm workload manager. `job.sbatch` is an example
of job file. Please modify the header (lines starting with `#SBATCH`)
to use your project allocation and set relevant parameters. You can
refer to [the documentation here](https://www.lcrc.anl.gov/systems/resources/bebop/)
for more information on how to configure such a job script.

Once modified, the job script may be submitted as follows.

```
$ sbatch ./job.sbatch
```

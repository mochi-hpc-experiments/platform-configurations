Perlmutter
==========

Please refer to the following issue if you are having trouble building at NERSC: [#51](https://github.com/mochi-hpc-experiments/platform-configurations/issues/51):

> TL;DR: don't load Perlmutter's spack module, clone your own Spack and do source spack/share/spack/setup-env.sh [(comment from @mdorier)](https://github.com/mochi-hpc-experiments/platform-configurations/issues/51#issuecomment-2535363752)

Programming environment
-----------------------

The example provided in this repository uses the gcc 12.3 compiler.  It
should be loaded by default; look for `PrgEnv-gnu` and `gcc-native/12.3.0`
in the output of `module list` to confirm.

Networking
----------

Perlmutter will use the `ofi+cxi://` transport in Mercury for native access to
the Slingshot network. The default environment includes a libfabric package
that is already properly configured to use it.  Note that this is only
available using the system libfabric libraries on Perlmutter; CXI (Slingshot)
support is not available in the upstream open source libfabric package.


Job management
--------------

Perlmutter uses slurm for scheduling and job management.  See `job.sbatch`
in this directory for an example job script that launches a Mochi benchmark.
Please modify the header to use your project allocation and set relevant
parameters. You can refer to NERSC documentation for more information about
running jobs.

Once modified, the job script may be submitted as follows.

```
$ sbatch job.sbatch
```

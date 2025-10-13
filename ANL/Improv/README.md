Improv
======


Programming environment
-----------------------

Before using Spack to compile Mochi on Improv, we recommend the following
changes to your environment to load default udpated versions of Python, gcc,
MPI, and perl:

- `module load python`
- `module load gcc/13.2.0`
- `module load openmpi`
- `module load perl`

Networking
----------

Improv uses an InfiniBand fabric.  The example in this directory is configured
to access it using libfabric and the `verbs://` transport in Mercury.

Note that it should also be possible to access the network using UCX and the
`ucx+dx://` transport in Mercury as well, but that configuration has not been
validated and is not enabled in this example.

Job management
--------------

Improv uses the PBS Pro workload manager.  `job.qsub` is an example of job
file. Please modify the header to use your project allocation and set
relevant parameters. You can refer to LCRC documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.qsub
```

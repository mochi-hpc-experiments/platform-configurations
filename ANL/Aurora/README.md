Sunspot
=======


Programming environment
-----------------------

This documentation is for the Aurora system at the ALCF as of October 2024.
We anticipate that the system environment will still change through the
friendly early access program.

These instructions assume the use of the default Intel oneAPI compiler.  In
order to find the necessary modules, something has to `module use
/soft/modulefiles` (e.g. in a shell init script) before invoking spack, but
once that's done, spack can find changes are needed to
the system module environment.

Networking
----------

Aurora will use the Slingshot `cxi://` transport in Mercury. The example Spack
environment file is already configured to use the appropriate system-provided
libfabric library to gain CXI support.  Upstream versions of libfabric compiled
from source do not support this transport.

See the comments in the `job.pbs` job script example in this directory for
potential `FI_*` environment variables to set which may improve behavior
under load with some versions of the HPE Slingshot software stack. 
These settings have not been validated, however.

Job management
--------------

Aurora uses the PBS Pro workload manager.  `job.pbs` is an example of job
file. Please modify the header to use your project allocation and set
relevant parameters. You can refer to ALCF documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.pbs
```


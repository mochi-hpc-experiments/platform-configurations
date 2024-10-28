Aurora
======


Programming environment
-----------------------

This documentation is for the Aurora system at the ALCF as of October 2024.
We anticipate that the system environment will still change through the
friendly early access program.

These instructions assume the use of the default Intel oneAPI compiler.

Networking
----------

Aurora will use the Slingshot `cxi://` transport in Mercury. The example Spack
environment file is already configured to use the appropriate system-provided
libfabric library to gain CXI support.  Upstream versions of libfabric compiled
from source do not support this transport.

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


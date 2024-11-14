Sunspot
=======


Programming environment
-----------------------

This documentation is for the Sunspot system at the ALCF. These instructions
assume the use of the default Intel oneAPI compiler.  No changes are needed to
the system module environment.

Networking
----------

Sunspot will use the Slingshot `cxi://` transport in Mercury. The example Spack
environment file is already configured to use the appropriate system-provided
libfabric library to gain CXI support.  Upstream versions of libfabric compiled
from source do not support this transport.

Job management
--------------

Sunspot uses the PBS Pro workload manager.  `job.pbs` is an example of job
file. Please modify the header to use your project allocation and set
relevant parameters. You can refer to ALCF documentation for more
information.

Once modified, the job script may be submitted as follows.

```
$ qsub ./job.pbs
```


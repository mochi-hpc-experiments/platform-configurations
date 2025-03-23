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

Process placement
-----------------

Aurora nodes have 2 sockets, each with 52 cores, however core 0 and rank 52
should be avoided as they may run service processes. Hence, 102 cores are available
in total. To bind ranks to the proper cores, use `--cpu-bind list:...` with an
explicit list of comma-separated cores for every column-separated rank.
For instance, `--cpu-bind list:1,2:3,4` maps two ranks to four cores, the first
rank is mapped to cores 1 and 2, the second to cores 3 and 4.

The `make-cpu-bind-list.sh` file in this folder can be used to create the list
for a desired number of processes. For instance `./make-cpu-bind-list.sh 8` will
generate a core mapping for 8 ranks. 4 will be placed on each socket, and each
rank will be mapped to as many cores as possible.

Note that the list will also contain numbers greater than 104; this is because
the list actually maps ranks to hyperthreads, with core `n` containing hyperthreads
`n` and `n+104`.

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


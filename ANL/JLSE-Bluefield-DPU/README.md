JLSE Bluefield DPUs
===================

Overview
--------

This example example documents how to install the Mochi software stack on an
NVIDIA BlueField DPU. We specifically use the JLSE BlueField 2 nodes in the
ANL JLSE environment as an exemplar (see
https://www.jlse.anl.gov/hardware-under-development/). These BlueField cards
can be flashed in DPU mode with an Ubuntu 22.04 image.

Similar steps should work with BlueField NICs in other environments.  If you
are using a different system image then the Spack environment will need to
be adjusted accordingly.  Beyond that, the main requirement is that a) you
have the ability to log into the DPU to execute commands on it directly and
that b) you have established external connectivity (e.g., via proxy if
required in your environment) for as required for Spack source
installations.

Caveats
-------

- These notes assume that you are using the BlueField card in "DPU mode",
  where they can be treated as interactive standalone hosts.
- These notes assume that you will compile code directly on the DPU. As a
  practical matter for extended use it would be more efficient to cross
  compile on a host machine and then transfer the resulting build to the
  DPU, but that is not documented here.
- These notes also assume that you will use an IP network for connectivity
  (i.e., no IB Verbs connetivity).  The cards are capable of RDMA, but this
  is a preliminary configuration that uses TCP/IP only.
- It may be possible to install and use additional Ubuntu packages on the
  DPU in order to avoid compiling so many package dependencies via Spack.

Programming environment
-----------------------

We use the default GNU compilers provided with the Ubuntu imaged flashed
onto the BlueField DPU.

Networking
----------

For now we assume the use of the `ofi+tcp://` transport, though BlueField
cards should be able to use `ofi+verbs://` if attached to a capable network
fabric.

Notes
-----
As of this writing (2024-05-15) we avoid using the system-provided Curl
package as it does not interoperate with the version of CMake built by
Spack.

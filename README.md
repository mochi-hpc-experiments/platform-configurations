Platform configurations for Mochi
=================================

This repository provides Spack configuration files, example job scripts, and
notes about building and running Mochi-based codes on various platforms.

Using an pre-configured spack.yaml
----------------------------------

This repository contains example Spack configurations for a variety of
platforms.  We also welcome additional contributions!

Each site/system subdirectory contains a `README.md` that documents any
special features of the platform as well as a `spack.yaml` file that
encapsulates a recommended software configuration for Mochi.
These `spack.yaml` files can be used as templates to create
[Spack environments](https://spack.readthedocs.io/en/latest/environments.html) in which to build Mochi packages.

We strongly recommend that you use version 1.0 or higher of Spack to build
Mochi. The most recent versions of the Mochi packages are not
compatible with older versions of Spack.  Also note that only a few core
Mochi packages are available in the default Spack package repository.  Most
Mochi packages (and the most up-to-date versions of the core packages) are
maintained in an independent [Mochi Spack
repository](https://github.com/mochi-hpc/mochi-spack-packages/) that must be
added to your Spack environment.

If you don't have Spack installed on your platform, clone it and set it up
as follows (update the branch name to refer to the most recent Spack release
tag):

```
$ git clone --branch v1.0.1 https://github.com/spack/spack.git
$ . spack/share/spack/setup-env.sh
```

Remember that the second line needs to be executed every time you open a new
terminal; it may be helpful to create an alias in your bashrc file as a
shortcut.

You will then need to clone `mochi-spack-packages`, which contains the Mochi packages.

```
$ git clone https://github.com/mochi-hpc/mochi-spack-packages.git
```

Now clone this platform-configurations repository and `cd` into the
subdirectory relevant to your platform. For example:

```
$ git clone https://github.com/mochi-hpc-experiments/platform-configurations.git
$ cd platform-configurations/ANL/Polaris
```

Then, execute the following commands
(changing _myenv_ into an appropriate name for your environment).

```
$ spack env create myenv spack.yaml
$ spack env activate myenv
$ spack repo add /where/you/cloned/mochi-spack-packages
```

At this point you can add root specs to your environment for any Mochi
packages that you wish to build.  For example, you can add the Thallium
package by running this command:

```
$ spack add mochi-thallium
```

Note that the `spack.yaml` file you used may already have a spec
added as an example (usually `mochi-margo`). You can remove it as
follows.

```
$ spack rm mochi-margo
```

Once you have added the specs you need in your environment, install
everything by executing the following command.
```
$ spack install
```

You may add more specs later on. Please refer to the [Spack
documentation](https://spack.readthedocs.io/) for more detailed information
about managing your Spack environment.

Creating a spack.yaml configuration for a new platform
------------------------------------------------------

You can start by creating and activating an empty Spack environment by
running the following command:

```
$ spack env create myenv
$ spack env activate myenv
```

You can then automatically detect available compilers and common
system-provided packages by running the following commands:

```
$ spack compiler find
$ spack external find
```

At this point you can find a baseline `spack.yaml` in
`$SPACK_ENV/spack.yaml`.  You can make a copy of this file and modify it
with external package specifications that are tailored to your system.  We
recommend that you use external packages for core build tools like automake,
autoconf, git, and cmake if possible.  See examples in the pre-configured
system directories for details.

If you are building Mochi packages that support MPI (such as `Bedrock`,
`Flock`, or `SSG` it is also important to specify the system MPI library
that you intend to use.  See examples in the pre-configured system
directories for details.

The most crucial part of the Spack configuraiton, however, is building the
network stack with the appropriate options so that Mochi has access to the
fastest native network protocol (e.g. Slingshot, Infiniband, or Omnipath)
available on your system.  The following examples show typical
configurations that you may wish to add to your `packages:` section.  Please
consult your facilities documentation or ask facility staff for assistance
if you are not sure how to proceed.

Notes:
* We always recommend the `~boostsys` variant of Mercury (the RPC framework
  used by all Mochi components).  This disables Mercury's dependency on
  external Boost libraries in favor of embedded versions of the Boost
  features that it uses.
* We always recommend the `~checksum` variant of Mercury (the RPC framework
  used by all Mochi components).  This disables additional user-space
  checksumming of control messages in Mercury that increase latency.  Note
  that checksumming is never applied to bulk RDMA transfers.
* Mercury is usually configured with either `ofi` or `ucx` support for most
  communication transports.  The corresponding libfabric or ucx package
  configurations determine how those abstractions will use the network.

```
# The following options are used by packages that Mochi depends
# upon.  You can start by choosing one of these examples and modifying
# it as needed to suit your system.   Please pick only one of these
# options, and place it unmodified in the packages: section of your
# spack.yaml file.
#
# TCP #############################################################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=tcp"
#
# Shared memory (no off-node comunication ##########################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "~ofi"
#
# IB/Verbs #########################################################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=rxm,verbs"
#
# IB/Verbs using a system-provided rdma-core/OFED library ##########
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=rxm,verbs"
#  rdma-core:
#    buildable: false
#    externals:
#    - spec: rdma-core@41.0
#      prefix: /usr
#
# OmniPath/PSM2 with built-in Mercury driver #######################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "~ofi +psm2"
#
# OmniPath/PSM2 with libfabric driver ##############################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=psm2"
#
# Aries/GNI #######################################################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=gni"
#
# Slingshot/CXI ##################################################
#    note the use of a vendor-supplied libfabric library; adjust the
#    version as appropriate for your system
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "+ofi"
#  libfabric:
#    require:
#    - "fabrics=cxi"
#  libfabric:
#    buildable: false
#    externals:
#    - spec: libfabric@1.15.0.0
#      modules:
#      - libfabric/1.15.0.0
#
# system-provided UCX ###########################################
#  mercury:
#    require:
#    - "~boostsys"
#    - "~checksum"
#    - "~ofi +ucx"
#  ucx:
#    buildable: false
#    externals:
#    - spec: ucx@1.15.0
#      modules:
#      - ucx/1.15.0
#

Contributing to this repository
-------------------------------

Should you want to contribute a `spack.yaml` for a particular machine,
please submit a merge request with it, and ensure the following.

*  The `spack.yaml` file should contain the compiler(s) that have been tested
   and confirmed to work with Mochi packages.
*  The `spack.yaml` file should try to list system-provided packages,
   in particular packages used for building (`cmake`, `autoconf`, etc.),
   and relevant system-provided MPI implementations.
   - Note that this must be done manually.  Spack provides a `spack external
     find` command that can be used to locate a subset of system packages,
     but it does not populate the `spack.yaml` file.
*  The `spack.yaml` file should contain the relevant variants for packages,
   in particular the transport methods to use with `libfabric`.
*  The path to the `spack.yaml` file should be of the form
   `<institution>/<platform>/spack.yaml`.

You can also contribute changes to existing `spack.yaml` files, in particular
to add working compilers, system packages, etc. As always, please test that
new setups work before creating a merge request.

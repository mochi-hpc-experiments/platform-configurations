Platform configurations for Mochi
=================================

This repository provides Spack configuration files, example job scripts, and
notes about building and running Mochi-based codes on various platforms.
Please refer to the subdirectory for your platform of interest for more
information.

The `generic` subdirectory contains a minimal Spack environment example that
can be used as a starting point for systems for which there is no existing
recipe.

Using spack.yaml files
----------------------

Each platform subdirectory in this repository provides a `spack.yaml` file.
A `spack.yaml` file fully describes a Spack environment, including
system-provided packages and compilers. It does so independently of any
`compilers.yaml` or `packages.yaml` files installed in `~/.spack`, thereby
preventing interference with user-specific spack configurations as much as
possible.

You may use `spack.yaml` files to create a
[Spack environment](https://spack.readthedocs.io/en/latest/environments.html)
in which Mochi packages will be installed.

If you don't have Spack installed on your platform, clone it and set it up
as follows.

NOTE: as of June 2025, the development branch of Spack is aligned with the
upcoming version 1.0 of Spack.  This version introduces numerous
improvements, but also some incompatibilities with older environment
configurations.  For now, we recommend using a version of Spack prior to 1.0
to ensure compabitility with the recipes provided in this repository:

```
$ git clone --branch v0.23.1 https://github.com/spack/spack.git
$ . spack/share/spack/setup-env.sh
```

Remember that the second line needs to be executed every time you open a new
terminal; it may be helpful to create an alias in your bashrc file as a
shortcut.

You will then need to clone `mochi-spack-packages`, which contains the Mochi packages.

```
$ git clone https://github.com/mochi-hpc/mochi-spack-packages.git
```

Now clone the present repository and `cd` into the subdirectory relevant
to your platform. For example:

```
$ git clone https://github.com/mochi-hpc-experiments/platform-configurations.git
$ cd platform-configurations/ANL/Bebop
```

Then, execute the following commands
(changing _myenv_ into an appropriate name for your environment).

```
$ spack env create myenv spack.yaml
$ spack env activate myenv
$ spack repo add /where/you/cloned/mochi-spack-packages
```

Change to a directory outside of the `platform-configurations` folders
and activate the environment as follows.

You may now add specs to your environment. For instance if you want
to install Margo, execute the following command.

```
$ spack add mochi-margo
```

If the `spack.yaml` file provides multiple compilers and you want
to use another than the default one, specify the compiler explicitely,
for example:

```
$ spack add mochi-margo %gcc@8.2.0
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

You may add more specs later on. For more information on how to manage
Spack environments, please refer to the Spack documentation.


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
*  Please make sure that your `spack.yaml` is a reliable way to work with
   Mochi on the target platform, other people will rely on it!

You can also contribute changes to existing `spack.yaml` files, in particular
to add working compilers, system packages, etc. As always, please test that
new setups work before creating a merge request.

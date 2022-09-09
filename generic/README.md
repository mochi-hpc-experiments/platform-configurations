generic
=======

The `spack.yaml` file in this directory is intended for use as a starting
point for a Mochi Spack environment on a system for which a specific recipe
is not available.  This may be particularly helpful for cluster systems or
workstations.  We recommend the following procedure to adapt this
example to your system:

1. Modify the `repos:` section in `spack.yaml` so that the path points to
   the location where you have cloned the `mochi-spack-packages` repository.
2. Uncomment the appropriate network configuration at the bottom of the
   `spack.yaml` file and update it as needed (i.e. with appropriate versions
   and paths if necessary).
3. Create and activate the environment (i.e. `spack create <name>
   spack.yaml` and `spack env activate <name>`)
4. Auto-detect any system packages that can be used with `spack external
   find`.
5. Use `spack concretize -f` to resolve package dependencies prior to
   installation.
6. Use `spack install` to install packages.
7. Optional: save the resulting `spack.yaml` file (it can be found in
   `$SPACK_ENV/spack.yaml`) for future use as a template to create other
   Mochi environments.

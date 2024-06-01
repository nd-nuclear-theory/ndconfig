# Installation instructions for ND nuclear theory projects using `ndconfig`#
### (shell, spncci, ...) ##

+ 03/07/16 (aem,mac): Created (spncci install instructions).
+ 04/19/16 (mac): Update.
+ 05/03/16 (mac): Update.
+ 05/17/16 (mac): Overhaul instructions.  Update repository location and branch.
+ 10/28/16 (mac): Update git pull notes.
+ 10/28/16 (mac): Branched off shell install instructions.
+ 10/29/16 (mac): Updated with pjf's Intel compilation fix.
+ 10/31/16 (mac): Update for Cori.
+ 11/04/16 (mac): Update h2stat example.
+ 11/08/16 (mac): Merge shell and spncci install.
  - Overhaul and clearly mark cluster-specific instructions.
  - Merge in notes from install_NDCRC.txt, created 6/29/16 (aem).
+ 11/13/16 (mac): Update shell h2mixer example.
+ 12/22/16 (mac):
  - Rename NERSC config files from "...-craype.mk" to
    "...-nersc.mk".
  - Add NDCRC config files.
+ 01/18/17 (mac): Add description of environment variables for
  mcscript scripting (with script/mfdn.py).
+ 05/03/17 (mac): Update for ndconfig submodule.
+ 05/27/17 (mac): Add note on "submodule init". Add Spectra library.
+ 05/29/17 (mac): Change example code directory name.
+ 12/25/17 (pjf): Update to Markdown.
+ 04/20/20 (mac): Update Spectra include directory structure.
+ 06/15/20 (mac): Overhaul to explain use of env files.
+ 06/18/20 (mac): Revise intro and sanity check example.
+ 07/09/21 (mac):
  - Revise to use ndconfig as standalone repository rather than submodule.
  - Switch to github as primary remote for repositories.
+ 05/15/23 (mac): Update notes on installation directory.
+ 09/05/23 (mac): Remove eigen3 from include path for Eigen installation.

----------------------------------------------------------------

These are the basic installation instructions for an Notre Dame nuclear theory
project (such as shell or spncci) which uses the ndconfig compiler and library
configuration files.

These instructions have two parts:

  * Setting up `ndconfig` itself (section 0)

  * Installing a project (such as `shell` or `spncci`) which uses `ndconfig`
    (sections 1ff)

0. Setting up `ndconfig`

  Change to the parent directory where you want the repository to be created,
  e.g.,
  ~~~~~~~~~~~~~~~~
  % cd ~/code
  ~~~~~~~~~~~~~~~~

  Clone the `ndconfig` repository:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git clone https://github.com/nd-nuclear-theory/ndconfig.git
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Then you need to set the `NDCONFIG_DIR` environment variable to point to this
  directory (in order for the `include` statements in the makefiles to work
  properly).  You will want to put this definition in the shell initialization
  file for your login shell.  That is, if you are a tcsh user, you will add
  something like the following to your .cshrc file:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ndconfig
  setenv NDCONFIG_DIR ${HOME}/code/ndconfig
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Alternatively, if you are a bash user, you will add something like the
  following to your .bashrc file:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # mcscript
  export NDCONFIG_DIR=${HOME}/code/ndconfig
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Cloning the project source (`shell`, `spncci`, ...) 

  For the following code examples, let us assume you are installing `shell`.
  Similar instructions would apply for `spncci`, etc.
  
  Change to the parent directory where you want the repository to be created,
  e.g.,
  ~~~~~~~~~~~~~~~~
  % cd ~/code
  ~~~~~~~~~~~~~~~~

  Clone the `shell` repository and all submodules:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git clone --recursive https://github.com/nd-nuclear-theory/shell.git
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Then change your working directory to the project directory for all the
  following steps:
  ~~~~~~~~~~~~~~~~
  % cd shell
  ~~~~~~~~~~~~~~~~

  If you want the bleeding-edge, potentially broken version, check out the
  `develop` branch:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git checkout -t origin/develop
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  a. Subsequently updating source
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git pull
  % git submodule update
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Or, if someone has added a new submodule to the project since your last pull,
  submodule first needs to be initialized, so the safest sequence of commands
  is:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git pull
  % git submodule init
  % git submodule update
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Makefile configuration (with `ndconfig`)

  You need to create a symbolic link `config.mk` to point to the correct
  configuration file in `ndconfig`.  The following instructions assume you have
  already set the `NDCONFIG_DIR` environment variable, or else you can
  explicitly enter `${HOME}/code/ndconfig` in its place when you invoke `ln`.

  On a generic system (e.g., your laptop), you can use the predefined
  configuration files for using the GNU or Intel compilers:
  
    + `config-gnu.mk` -- for GNU gcc 4/5/6

    + `config-intel.mk` -- for Intel

  For instance, for compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s ${NDCONFIG_DIR}/config-gnu.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  However, for HPC systems, the compiler configurations are often nonstandard.
  You may be expected to call the compilers with special options or through
  "wrapper" commands.  Most of the configuration is the same as for use on a
  generic system with GNU or Intel compilers, but a few definitions need to be
  overwritten.  Therefore, the cleanest and most maintainable approach is to
  indirectly use `config-gnu.mk` or `config-intel.mk`, by through a wrapper
  file, which uses a makefile `include` statement to include one of these files,
  then overrides a few definitions.

  In `ndconfig`, you can already find such wrappers for use at the ND CRC and at
  NERSC.  See, e.g., `config-gnu-nersc.mk` as an example.  If you are running on
  some other HPC system, these should serve as examples to get you started on
  writing your own wrappers.

  > @NDCRC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s ${NDCONFIG_DIR}/config-gnu-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s ${NDCONFIG_DIR}/config-intel-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  > Actually, as of when these instructions were written, the generic config gnu
  > or intel config files would work just fine at the NDCRC.  But it is good to
  > have the framework in place to easily add flags specific to the NDCRC, e.g.,
  > architecture optimizations.

  > @NERSC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  || % ln -s ${NDCONFIG_DIR}/config-gnu-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s ${NDCONFIG_DIR}/config-intel-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > It is important to use these "`...-nersc.mk`" config files, since they
  > ensure that make invokes the correct Cray Programming Environment compiler
  > wrapper "CC".  This is needed to generate optimized executables for the
  > compute nodes and to link to the correct libraries.

3. Setting up compiler and libraries

  You will need to make sure certain libraries are installed, and then that
  certain environment variables are set (at compile time) so that the makefile
  can find these libraries.  Here we give general instructions for installing
  libraries and setting environment variables "from scratch".  However, if you
  are working on a cluster, these libraries may already be installed, and you
  may simply have to do a "module load" to configure your environment variables
  properly so that you can use the libraries.
  
  <em> In particular, if you are working at NDCRC or NERSC, we have already
  collected all the commands in a single "environment" file.  You do not need to
  type them from scratch.  See Sec. 3' below.  If you are working at another
  cluster, it is still useful to look at these "environment" files for examples
  of the module load commands you may need to use. </em>

  Boost: Make sure Boost is installed and that the environment variable
  `BOOST_ROOT` points to the root directory for this installation (unless the
  installation is already in the compiler's default search path, e.g., in
  /usr/local).  E.g., under Ubuntu, for a global installation:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % sudo apt install libboost-all-dev
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Or, under macOS, with Homebrew:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % brew install boost
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  GSL: Make sure GSL is installed and that the environment variable `GSL_DIR`
  points to the install prefix for this installation (unless the installation is
  already in the compiler's default search path, e.g., in /usr/local).

  E.g., under Ubuntu, for a global installation:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % sudo apt install libgsl-dev
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Eigen (version 3): The Eigen library is a template library, so there are no
  compiled binaries, just header files.  The environment variable `EIGEN3_DIR`
  should be set to the install prefix, so that the header files are found under
  `${EIGEN3_DIR}\include`.
  
  Confusingly, the directory structure beneath `${EIGEN3_DIR}\include` varies
  between different installations.  Includes statements in the code should be of
  the form, e.g., `#include <Eigen/Array>`.  Here, `<header>` represents the
  files `Array`, `Cholesky`, etc.  Thus, the natural directory structure would
  be such that the header files are found as

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ${EIGEN3_DIR}/include/Eigen/<header>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  However, many installations have an extra layer to the subdirectory
  structure, with the headers buried in a subdirectory named `eigen3`.  That is, 
  the header files are found as
   
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ${EIGEN3_DIR}/include/eigen3/Eigen/<header>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  (This is the way the source files are arranged in the distribution tar file.
  It is also, by default, the directory structure created by `cmake install`.)
  The `config.mk` files provided with this `ndconfig` repository provide a
  workaround, to ensure that the header files will also be found if their paths
  are of either of these two forms.

  The Eigen library is available as a module on some clusters.  Alternatively,
  you may need to download the latest version from `https://eigen.tuxfamily.org`
  (or clone it from `https://gitlab.com/libeigen/eigen.git`).  See the `INSTALL`
  file that comes with Eigen for guidance.

  For example, at the NDCRC, we use our own copy of Eigen, in our nuclthy
  project directory:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.3.7
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Or, under macOS, with Homebrew, Eigen is installed under `/usr/local` as:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % brew install eigen
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Spectra: The Spectra library is a template library, so there are no compiled
  binaries, just header files.  The environment variable `SPECTRA_DIR` should be
  set to the install prefix for these files, so that the headers are found as
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ${SPECTRA_DIR}/include/Spectra/<header>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  [That is, starting with Spectra version 0.7.0, the header files are in a
  subdirectory named `Spectra`, and include directives should be of the form,
  e.g.,  `#include <Spectra/SymmEigenSolver.h>`.]

  For example, at the NDCRC, we use our own copy, in our shared nuclthy project
  directory:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv SPECTRA_DIR /afs/crc.nd.edu/group/nuclthy/opt/spectra
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3'. Using predefined "environment" files to set up compiler and libraries

  As you can see, there may be a large number of environment variables you have
  to set or modules you have to load, and these will vary from cluster to
  cluster.  It is more convenient to save these commands once, in a file, which
  you can then "source" from your shell command line.  You can also then share
  these definitions with other users on the same cluster.  In `ndconfig`, you can
  find a few examples of such files from our group, for compilers and clusters
  we are currently using:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  env-gnu-ndcrc.csh
  env-gnu-ndcrc.sh
  env-gnu-nersc.csh
  env-gnu-nersc.sh
  env-intel-ndcrc.csh
  env-intel-ndcrc.sh
  env-intel-nersc.csh
  env-intel-nersc.sh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  For instance, if you are doing a build with gnu compilers at NERSC, and if
  `tcsh` is your login shell, the following takes care of all the module loads:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  source ${NDCONFIG_DIR}/env-gnu-nersc.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Or, if `bash` is your login shell:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  source ${NDCONFIG_DIR}/env-gnu-nersc.sh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  A few comments:
  
  + The commands for setting environment variables differ between `shell`s.
  Namely, those in the "csh" family (e.g., tcsh) use "setenv", while those in
  the sh family (e.g., bash) use "export".  So we maintain two versions of each
  environment file, with the extension .csh or .sh.  (Actually, when changes are
  needed, we only update the .csh files, then run a simple script
  "bashify_all.csh" to generate the .sh files from these.)

  + The environment file needs to be *sourced* into your shell, as above, not
  run as a script.  If you run it as a script, without the "source" command, it
  will run in a subshell, the environment variable definitions will be lost.

  + A more sophisticated approach, rather than sourcing an "environment" file
  like this, would be to define your own module file.  We may move to this
  procedure in the future.

4. Building

  As noted in Secs. 3 and 3' above, make sure you have loaded the any necessary
  modules and set any necessarily environment variables to select the compiler
  and libraries you wish to use.

  Then, "make all".  Unless you are very patient, a parallel make (with the -j
  option) is strongly recommended for speed:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make all -j8
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  To copy all executable binaries to installation directory:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make install
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  The default installation directory is just the subdirectory `install\bin`,
  which is not very useful.  Rather, if you plan to use use the `mcscript`
  scripting (which you probably are!), make sure to set the environment variable
  `MCSCRIPT_INSTALL_HOME` before installing (see the `INSTALL.md` file for
  `mcscript`).  This will define the installation directory for `make install`
  to use now, and this directory is where the `mcscript` scripting will expect
  to find your executables later.  E.g., a typical configuration for our group
  is to set `MCSCRIPT_INSTALL_HOME` to `${HOME}/code/install`.

  > @NERSC: We need to keep binaries for different architectures separate.  The
  > files are thus installed to `install/${CRAY_CPU_TARGET}/<code>/bin`, e.g.,
  > `install/x86-milan/shell/bin`.  But you do not have to worry about this.
  > This is taken care of when we set the install_prefix variable in the
  > `config-gnu-nersc.mk` or `config-intel-nersc.mk files`.

  > @NERSC: For large parallel runs, the executable file should be on a
  > filesystem which can be accessed from compute nodes with high bandwidth.  It
  > should not be in your home directory.  We use the `/global/common/software'
  > directory.  Thus, `MCSCRIPT_INSTALL_HOME` is set to
  > `/global/common/software/<repsitory>/<user>/install`.

  Note that `ndmakefile` supports other "targets", beyond just `all` and `install`.  To see all
  options provided by `ndmakefile`:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make help
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5. Optional sanity check for `shell` project

If you would like to try running a program, try the following:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  <install_directory>/h2stat --verify doc/h2/h2v0/example/tbme-identity-tb-2-h2v0.dat
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the above, you will need to substitute the correct installation path for
`h2stat`, e.g., `${MCSCRIPT_INSTALL_HOME}/${CRAY_CPU_TARGET}/shell/bin/h2stat`.

The output should be something like this:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  h2stat  -- MFDn H2 file statistics
  version: 0.1.3-0-g7458fbd

  Input stream
    File: doc/h2/h2v0/example/tbme-identity-tb-2-h2v0.dat
    Format: 0 (text)
    Operator properties: J0 0 g0 0 Tz0 0
    Orbitals: p 6 n 6 (oscillator-like true)
    Truncation: p 2.0000 n 2.0000 pp 2.0000 nn 2.0000 pn 2.0000
    Sectors: pp 7 nn 7 pn 7 => total 21
    Matrix elements: pp 32 nn 32 pn 110 => total 174

  Mode: verify

  Verification scan
  .....................
  (Total time: 0.0077458)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

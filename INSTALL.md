# Installation instructions for ND nuclear theory projects #
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

----------------------------------------------------------------

1. Retrieving source

  These are the basic installation instructions for an Notre Dame nuclear theory
  project (such as shell or spncci) which uses the ndconfig compiler and library
  configuration files.

  For the following code examples, let us assume you are installing shell.
  
  Change to the parent directory where you want the repository to be created,
  e.g.,
  ~~~~~~~~~~~~~~~~
  % cd ~/code
  ~~~~~~~~~~~~~~~~

  Clone the `shell` repository and all submodules.  If you are cloning from our
  mirror repository on github:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git clone --recursive https://github.com/nd-nuclear-theory/shell.git
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > Notre Dame local users: You can instead use our development repository at
  > the ND CRC:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git clone --recursive ssh://<netid>@crcfe01.crc.nd.edu/afs/crc.nd.edu/group/nuclthy/git/code/shell.git
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  > But, if you are cloning from the ND CRC, please first our instructions in
  > readme-nuclthy-git.md on setting up your ~/.ssh/config file.  Otherwise, the
  > recursive clone will hang.

  Then change your working directory to the project directory for all the
  following steps:
  ~~~~~~~~~~~~~~~~
  % cd shell
  ~~~~~~~~~~~~~~~~

  a. Subsequently updating source
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git pull
  % git submodule update
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Or, if someone has added a new submodule since your last pull, the
  submodule first needs to be initialized:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git pull
  % git submodule init
  % git submodule update
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2. Makefile configuration

  You need to create a symbolic link `config.mk` to point to the
  correct configuration file.

  On a generic system, you can use the predefined configuration files in
  shell/config:
    + config/ndconfig/config-gnu.mk -- for GNU gcc 4/5/6
    + config/ndconfig/config-intel.mk -- for Intel

  For instance, for compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-gnu.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  However, for HPC systems, you may be expected to call the compilers with
  special options or through "wrapper" commands, to ensure that the executables
  are compiled to run properly on that system.  To do so, you can "wrap" one
  of these generic config files as an include file, then override a few variable
  settings as needed.  See, e.g., config/ndconfig/config-gnu-nersc.mk as an example.

  > @NDCRC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-gnu-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-intel-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  > Actually, as of when these instructions were written, the generic config gnu
  > or intel config files would work just fine at the NDCRC.  But it is good to
  > have the framework in place to easily add flags specific to the NDCRC, e.g.,
  > architecture optimizations.

  > @NERSC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  || % ln -s config/ndconfig/config-gnu-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-intel-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > It is important to use these "...-nersc.mk" config files, since they
  > configure make to invoke the correct Cray Programming Environment compiler
  > wrapper "CC".  This is needed to generate optimized executables for the
  > compute nodes and to link to the correct libraries.

3. Setting up compiler and libraries

  You will need to make sure certain libraries are installed, and then that
  certain environment variables are set (at compile time) so that the makefile
  can find these libraries.  Here we give general instructions for installing
  libraries and setting environment variabls "from scratch".  However, if you
  are working on a cluster, these libraries may already be installed, and you
  may simply have to do a "module load" to configure your environment variables
  properly so that you can use the libraries.
  
  <em> In particular, if you are working at NDCRC or NERSC, we have already
  collected all the commands in a single "environment" file.  You do not need to
  type them from scratch.  See Sec. 3' below.  If you are working at another
  cluster, it is still useful to look at these "environment" files for examples
  of the module load commands you may need to use. </em>

  Compilers: If compiling with gcc, version 4.8 or higher is needed, for the
  full C++11 functionality.  Depending on your cluster, you may need to also
  load certain modules to control which compiler or compiler version is used.

  Boost: Make sure Boost is installed and that the environment
  variable `BOOST_ROOT` points to this installation (unless the
  installation is already in the compiler's default search path,
  e.g., in /usr/local).

  GSL: Make sure GSL is installed and that the environment variable
  `GSL_DIR` points to this installation (unless the installation is
  already in the compiler's default search path, e.g., in
  /usr/local).

  Eigen (version 3): The Eigen library is a template library, so
  there are no compiled binaries, just header files.  The environment
  variable `EIGEN3_DIR` should be set to point to the parent directory
  of a tree containing these files, specificially, be sure that the
  tree looks like "include/eigen3/Eigen/<headers>".  Here, <headers>
  represents the files {Array,Cholesky,...}.  While the Eigen library
  is available as a module on systems, it is often preferable to
  download the latest version and move the header files into a tree
  like this.

  For example, at the NDCRC, we use our own copy, in our shared nuclthy project
  directory:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.3.7
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Spectra: The Spectra library is a template library, so there are no compiled
  binaries, just header files.  The environment variable `SPECTRA_DIR` should be
  set to point to the parent directory of a tree containing these files,
  specificially, be sure that the tree looks like "include/Spectra/<headers>".
  [That is, starting with Spectra version 0.7.0, the header files are in a
  subdirectory named Spectra, and include directives should be of the form,
  e.g., "Spectra/SymmEigenSolver.h".]

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
  these definitions with other users on the same cluster.  In ndconfig, you can
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

  For instance, if you are doing a build with Intel compilers at NERSC, and
  using tcsh as your shell, the following takes care of all the module loads:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  source config/ndconfig/env-intel-nersc.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  A few comments:
  
  + The commands for setting environment variables differ between shells.
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

  As noted in Sec. 3 above, make sure you have loaded the any necessary modules
  and set any necessarily environment variables to select the compiler and
  libraries you wish to use.

  > @NERSC: If you prefer to switch from the intel compiler to the gnu compiler:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module swap PrgEnv-intel PrgEnv-gnu
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Then, "make all".  A parallel make (with the -j option) is strongly
  recommended for speed:
  
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make all -j8
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  To copy all executable binaries to the directory install/bin:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make install
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC: We need to keep binaries for different architectures separate.  The
  > files are thus installed to `install/$(CRAY_CPU_TARGET)/bin`, e.g.,
  > `install/haswell/bin` or `install/mic-knl/bin`.  But you do not have to
  > worry about this.  This is taken care of when we set the install_prefix
  > variable in the config-gnu-nersc.mk or config-intel-nersc.mk files.

5. Optional sanity check for shell project

If you would like to try running a program, try the following:

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  programs/h2utils/h2stat --verify doc/h2/h2v0/example/tbme-identity-tb-2-h2v0.dat
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

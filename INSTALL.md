# Installation instructions for ND nuclear theory projects #
### (shell, spncci, ...) ##

+ 3/7/16 (aem,mac): Created (spncci install instructions).
+ 4/19/16 (mac): Update.
+ 5/3/16 (mac): Update.
+ 5/17/16 (mac): Overhaul instructions.  Update repository location and branch.
+ 10/28/16 (mac): Update git pull notes.
+ 10/28/16 (mac): Branched off shell install instructions.
+ 10/29/16 (mac): Updated with pjf's Intel compilation fix.
+ 10/31/16 (mac): Update for Cori.
+ 11/4/16 (mac): Update h2stat example.
+ 11/8/16 (mac): Merge shell and spncci install.
  - Overhaul and clearly mark cluster-specific instructions.
  - Merge in notes from install_NDCRC.txt, created 6/29/16 (aem).
+ 11/13/16 (mac): Update shell h2mixer example.
+ 12/22/16 (mac):
  - Rename NERSC config files from "...-craype.mk" to
    "...-nersc.mk".
  - Add NDCRC config files.
+ 1/18/17 (mac): Add description of environment variables for
  mcscript scripting (with script/mfdn.py).
+ 5/3/17 (mac): Update for ndconfig submodule.
+ 5/27/17 (mac): Add note on "submodule init". Add Spectra library.
+ 5/29/17 (mac): Change example code directory name.
+ 12/25/17 (pjf): Update to Markdown.

----------------------------------------------------------------

1. Retrieving source

  Change to the directory where you want the repository to be installed,
  e.g.,
  ~~~~~~~~~~~~~~~~
  % cd ~/code
  ~~~~~~~~~~~~~~~~

  Clone the `shell` repository and all submodules.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % git clone --recursive <URL>
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Then change your working directory (cd) to the project directory for
  all the following steps.

  > Workaround: If the process hangs while cloning from the ND CRC, kill with
  > Ctrl-C, clean up with `rm -rf shell`, and add the following to your `~/.ssh/config`:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  Host *.nd.edu
      ControlMaster auto
      ControlPath ~/.ssh/persist/ssh-%r@%h:%p
      ControlPersist 5m
      ServerAliveInterval 60
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > and create the `~/.ssh/persist/` directory with
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  mkdir ~/.ssh/persist
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

2. Compiler

  If compiling with gcc, version 4.8 or higher is needed, for the
  full C++11 functionality.

  > @NDCRC: For gnu:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load gcc/4.9.2
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC: Even if using the intel compiler suite, loading GCC 4.8+
  > (for C++11 compatibility) is still required, since gcc is used
  > internally by icpc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load gcc
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > If you prefer to switch from the intel compiler to the gnu
  > compiler:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module swap PrgEnv-intel PrgEnv-gnu
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

3. Libraries

  For convenience, we provide scripts to load required modules and set
  relevant environment variables. These may be sourced by running or adding
  these lines to your rc files. See Sec. 5 below.

  Boost: Make sure Boost is installed and that the environment
  variable `BOOST_ROOT` points to this installation (unless the
  installation is already in the compiler's default search path,
  e.g., in /usr/local).

  > @NDCRC: For use with gcc/4.9.2:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load boost/1.58
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load boost
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  GSL: Make sure GSL is installed and that the environment variable
  `GSL_DIR` points to this installation (unless the installation is
  already in the compiler's default search path, e.g., in
  /usr/local).

  > @NDCRC:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load boost
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module load gsl
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Eigen (version 3): The Eigen library is a template library, so
  there are no compiled binaries, just header files.  The environment
  variable `EIGEN_DIR` should be set to point to the parent directory
  of a tree containing these files, specificially, be sure that the
  tree looks like "include/eigen3/Eigen/<headers>".  Here, <headers>
  represents the files {Array,Cholesky,...}.  While the Eigen library
  is available as a module on systems, it is often preferable to
  download the latest version and move the header files into a tree
  like this.

  > @NDCRC: We use our own copy, in the nuclthy project space.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.2.10
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC: Although Eigen is installed as a module on Edison, the
  > installation tends to lag, and Eigen is missing from Cori
  > (10/31/16).  So we use our own copy, in the m2032 project space.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv EIGEN3_DIR /global/project/projectdirs/m2032/opt/eigen-3.2.10
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Spectra: The Spectra library is a template library, so there are no
  compiled binaries, just header files.

  > @NDCRC: We have a copy in the nuclthy project space.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv SPECTRA_DIR /afs/crc.nd.edu/group/nuclthy/opt/spectra-0.5.0
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC: We have a copy in the m2032 project space.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % setenv SPECTRA_DIR /global/project/projectdirs/m2032/opt/spectra-0.5.0
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4. Makefile configuration

  You need to create a symbolic link `config.mk` to point to the
  correct configuration file.  On a generic system, you can use the
  predefined configuration files in shell/config:
    + config/ndconfig/config-gnu.mk -- for GNU gcc 4/5/6
    + config/ndconfig/config-intel.mk -- for Intel

  e.g., for compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-gnu.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  For HPC systems with more specialized compiler invocations, you can
  "wrap" one of these generic config files as an include file, then
  override a few variable settings.  See config/ndconfig/config-gnu-nersc.mk as
  an example.

  > @NDCRC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-gnu-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-intel-ndcrc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > Actually, the generic config gnu or intel config files would work
  > just fine at the NDCRC, but it is good to have the framework in
  > place to easily add flags specific to the NDCRC, e.g.,
  > architecture optimizations.

  > @NERSC: For compiling under gcc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  || % ln -s config/ndconfig/config-gnu-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > For compiling under intel:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/config-intel-nersc.mk config.mk
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > It is important to use these "...-nersc.mk" config files, since
  > they configure make to invoke the correct Cray Programming
  > Environment compiler wrapper "CC" to generate optimized executables
  > for the compute nodes and to link to the correct libraries.

5. Build

  As a shortcut, it is convenient to collect all the above module
  loads and setenv commands into a single file, which can be sourced
  before attempting a build.

  Important: This needs to be *sourced* into csh (not run as a script)
  so that the environment variable definitions are retained by the
  shell.

  > @NDCRC:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/module-load-ndcrc.csh module-load.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > Then, in each new shell session or in ~/.cshrc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % source module-load.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ln -s config/ndconfig/module-load-nersc.csh module-load.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > Then, in each new shell session or in ~/.cshrc:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % source module-load.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  > or, for gnu,
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % module swap PrgEnv-intel PrgEnv-gnu
  % source module-load-nersc.csh
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  Then, "make all", and a parallel make (with the -j option) is
  strongly recommended for speed:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make all -j8
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  To copy all executable binaries to the directory install/bin:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % make install
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  > @NERSC: We need to keep binaries for different architectures
  > separate.  The files will be installed to
  > `install/$(CRAY_CPU_TARGET)/bin`, e.g., `install/haswell/bin` or
  > `install/mic-knl/bin`.

  You may wish to define the environment variable `SHELL_DIR` to point
  to the installation directory, so that you can then run, e.g.,
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ${SHELL_DIR}/bin/h2mixer
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  in scripts.

----------------------------------------------------------------

Further setup for shell project:

1. Sanity check:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % cd programs/h2utils
  % ./h2mixer < test/h2mixer_identity-v0.in
  % ./h2stat --verify test/tbme-identity-tb-2-v0.dat
  % ./h2stat --verify test/tbme-identity-tb-2-v0.bin
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  You should see something like the following output:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  h2stat  -- MFDn H2 file statistics

  Input stream
    File: test/tbme-identity-tb-2-v0.dat
    Format: 0 (text)
    Orbitals: p 6 n 6 (oscillator-like true)
    Truncation: p 2.0000 n 2.0000 pp 2.0000 nn 2.0000 pn 2.0000
    Sectors: pp 7 nn 7 pn 7 => total 21
    Matrix elements: pp 32 nn 32 pn 110 => total 174

  Mode: verify

  Verification scan
  .....................
  (Total time: 0)
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  You can also try out the conversion code h2conv:
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  % ./h2conv 15099 test/tbme-identity-tb-2-v0.dat test/tbme-identity-tb-2-v15099.dat
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

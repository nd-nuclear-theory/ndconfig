# NERSC environment file for use with gnu compilers (cpu target)
#
# Setup:
#
#   - You will first need to install certain spack modules:
#
#     spack install gsl 
#     spack install boost
#
#   - For codes (e.g., SpNCCI) using the spectra template library, you will need
#     to obtain access to /global/common/software/m2032/spectra or provide an
#     alternate definition of SPECTRA_DIR.
#
# Note: This NERSC environment file is meant to be usable by non-m2032 users, to
# the extent possible.  It should avoid referencing files requiring m2032 group
# file read permissions (e.g., installed in /global/common/software/m2032) where
# possible, as these will not be available to all users.
#
# 12/01/25 (zz/mac): Move away from using NERSC-provided predefined spack
#   environments, which are no longer available, as NERSC moves away from
#   spack-based e4s deployment (NERSC INC0245375).

module load PrgEnv-gnu

if ( "$NERSC_HOST" == "perlmutter" ) then
  # 06/21/23 (mac): Based on initial module set shared by py (working with rt):
  #   module load e4s
  #   module load gsl
  #   spack env activate gcc
  #   spack load gsl boost/zoben4a

  module load spack
  
  # 12/01/25 (zz/mac): Environment gcc no longer available, 
  ## spack env activate gcc

  # gsl
  # 01/22/25 (zz): gsl@2.7.1 also works
  # 12/01/25 (zz/mac): Need to install spack gsl module first
  spack load gsl@2.8

  # 06/17/25 (mac/zz): In mfdn-transitions, since cmake strips "non-toolchain
  # portion of runtime path" on install, the RPATH in the installed binary is
  # missing the GSL library location.  The workaround is to explicitly add this
  # library location to LD_LIBRARY_PATH at run time.
  setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${GSL_ROOT_DIR}/lib
  
  # boost
  #
  # 05/21/24 (mac): Original recommended boost/zoben4a no longer available.
  #   Generic "spack load boost" gives "Error: boost matches multiple packages."
  #   and lists several matching packages.  Pick one and try...
  #
  #   nxqk3hn boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #   bofy2gb boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #   jn7ias4 boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #   7v65wrl boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #   2duyuvm boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #   2yqnluo boost@1.83.0%gcc@12.3.0 arch=linux-sles15-zen3
  #
  # 07/25/24 (mac): Although nxqk3hn works just fine for building shell, it
  # causes `cmake -B` to choke when building basis, etc.  Use bofy2gb instead.
  #
  # 01/22/25 (zz): All of the following are tested for building shell
  # spack load boost/gy2bwpu: works
  # spack load boost/etpwsek: works
  # spack load boost/4znawlj: works
  # spack load boost/r3flolp: works
  # spack load boost/t4shrus: works
  # 12/01/25 (zz/mac): boost/t4shrus is no longer available

  # 12/01/25 (zz/mac): Need to install spack boost module first
  spack load boost

  # eigen
  #
  # 05/31/24 (mac): Module "eigen/3.40" on perlmutter provides directory
  # structure $EIGEN_DIR/include/eigen3/Eigen/.
  setenv EIGEN3_DIR "/usr"

  # spectra
  setenv SPECTRA_DIR "/global/common/software/m2032/shared/common/spectra/0.9.0"
    
endif

# need python for scripting
module load python
# parallel: for use in mcscript config-slurm-nersc.py
## module load parallel  # 02/26/25 (mac): now available at NERSC without a module
module load cmake

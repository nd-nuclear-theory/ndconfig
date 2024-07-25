# This "generic" NERSC environment file is meant for non-m2032 users.  It should
# avoid referencing files requiring m2032 group file read permissions (e.g., the
# m2032 spack environment or /global/common/software/m2032) where possible, as
# these will not be available to all users.

module load PrgEnv-gnu

if [[ "$NERSC_HOST" == "perlmutter" ]]; then
  # 06/21/23 (mac): Based on initial module set shared by py (working with rt):
  #   module load e4s
  #   module load gsl
  #   spack env activate gcc
  #   spack load gsl boost/zoben4a

  module load e4s
  spack env activate gcc

  # gsl
  spack load gsl

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
  spack load boost/bofy2gb

  # eigen
  #
  # 05/31/24 (mac): Module "eigen/3.40" on perlmutter provides directory
  # structure $EIGEN_DIR/include/eigen3/Eigen/.
  module load eigen

  # spectra
  export SPECTRA_DIR="/global/common/software/m2032/shared/common/spectra/0.9.0"
    
fi

# need python for scripting
module load python
# parallel: for use in mcscript config-slurm-nersc.py
module load parallel
module load cmake

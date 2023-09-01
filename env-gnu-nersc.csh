if ( "$NERSC_HOST" == "perlmutter" ) then
  # 06/21/23 (mac): module set from py working with rt 
  module load e4s
  module load gsl
  spack env activate gcc
  spack load gsl boost/zoben4a

  # template libraries
  # contains an eigen3/include/Eigen tree
  setenv EIGEN3_DIR "/global/common/software/m2032/shared/common/eigen3/3.4.0"
  setenv SPECTRA_DIR "/global/common/software/m2032/shared/common/spectra/0.9.0"
    
endif

module load python
module load parallel  # for use in mcscript config-slurm-nersc.py
module load cmake

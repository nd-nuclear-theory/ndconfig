if ( "$NERSC_HOST" == "perlmutter" ) then
  module load PrgEnv-gnu

  # activate spack
  # 05/09/23 (mac): stay with spack/0.19.0 due to apparent bug in spack/0.19.2  
  # 05/09/23 (mac): gymnastics of loading cpu and then reloading gpu is to work
  #   around spack module conflict with cudatoolkit module (Steve Leak 02/27/23)
  module load cpu spack/0.19.0; module load gpu
  spack env activate --prompt --dir=/global/common/software/m2032/shared/spack-perlmutter

  # boost
  spack load boost%gcc

  # eigen
  spack load eigen
  setenv EIGEN3_DIR `pkg-config --variable=prefix eigen3`
  # non-spack legacy installation
  ##setenv EIGEN3_DIR /global/common/software/m2032/shared/common/eigen3/3.4.0
  ##setenv CMAKE_PREFIX_PATH ${EIGEN3_DIR}:${CMAKE_PREFIX_PATH}

  # spectra
  spack load spectra%gcc
  # non-spack legacy installation
  #
  # 05/09/23 (mac): would need to do a proper cmake install on spectra for it to
  # be accessable this way
  ## setenv SPECTRA_DIR /global/common/software/m2032/shared/common/spectra/0.9.0
  ## setenv CMAKE_PREFIX_PATH ${SPECTRA_DIR}:${CMAKE_PREFIX_PATH}

  # gsl
  spack load gsl%gcc
  setenv GSL_DIR `pkg-config --variable=prefix gsl`
  setenv LD_LIBRARY_PATH ${GSL_DIR}/lib:${LD_LIBRARY_PATH}
  # NERSC module installation
  #
  # 05/09/23 (mac): there is now a global gsl/2.7 on perlmutter,
  # TODO (mac): test if resultant am package works with python
  ## module load gsl
  
else if ( "$NERSC_HOST" == "cori" ) then
  setenv MODULEPATH /global/common/software/m2032/shared/modulefiles:$MODULEPATH

  module -s swap PrgEnv-intel PrgEnv-gnu
  module switch gcc/9.3.0
  module unload cray-libsci
  module load craype-hugepages2M
  module load eigen3

  # m2032 custom module files -- not supported on perlmutter
  module load spectra
  module load boost-mpi
  module load gsl
endif

module load python
module load parallel  # for use in mcscript config-slurm-nersc.py
module load cmake

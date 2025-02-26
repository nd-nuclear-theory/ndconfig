if [[ "$NERSC_HOST" == "perlmutter" ]]; then

  module load PrgEnv-gnu

  # activate spack (using m2032 homegrown stack environment)
  # 05/09/23 (mac): gymnastics of loading cpu and then reloading gpu is to work
  #   around spack module conflict with cudatoolkit module (Steve Leak 02/27/23)
  module load cpu spack; module load gpu
  spack env activate --prompt --dir=/global/common/software/m2032/shared/spack-perlmutter

  # boost
  spack load boost%gcc
  export LD_LIBRARY_PATH=${BOOST_ROOT}/lib:${LD_LIBRARY_PATH}

  # eigen
  #
  # 05/31/24 (mac): Module "eigen/3.40" on perlmutter provides directory
  # structure $EIGEN_DIR/include/eigen3/Eigen/.
  module load eigen
  # m2032 spack installation
  ## spack load eigen
  ## export EIGEN3_DIR=`pkg-config --variable=prefix eigen3`
  # non-spack legacy installation
  ## export EIGEN3_DIR=/global/common/software/m2032/shared/common/eigen3/3.4.0
  ## export CMAKE_PREFIX_PATH=${EIGEN3_DIR}:${CMAKE_PREFIX_PATH}

  # spectra
  spack load spectra%gcc
  # non-spack legacy installation
  #
  # 05/09/23 (mac): would need to do a proper cmake install on spectra for it to
  # be accessable this way
  ## export SPECTRA_DIR=/global/common/software/m2032/shared/common/spectra/0.9.0
  ## export CMAKE_PREFIX_PATH=${SPECTRA_DIR}:${CMAKE_PREFIX_PATH}

  # gsl
  spack load gsl%gcc
  export GSL_DIR=`pkg-config --variable=prefix gsl`
  export LD_LIBRARY_PATH=${GSL_DIR}/lib:${LD_LIBRARY_PATH}
  # NERSC module installation
  #
  # 05/09/23 (mac): there is now a global gsl/2.7 on perlmutter,
  # TODO (mac): test if resultant am package works with python
  ## module load gsl
fi

module load python
# parallel: for use in mcscript config-slurm-nersc.py
## module load parallel  # 02/26/25 (mac): now available at NERSC without a module
module load cmake

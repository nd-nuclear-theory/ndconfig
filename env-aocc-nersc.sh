if [[ "$NERSC_HOST" == "perlmutter" ]]; then
  module load PrgEnv-aocc
  # TODO: use Spack to generate module on Perlmutter
  export EIGEN_DIR=/global/common/software/m2032/shared/common/eigen3/3.4.0
fi

if [[ "$NERSC_HOST" == "cori" ]]; then
  return 1
fi

module load spectra
module load boost-mpi
module load gsl
module load python
## module load parallel  # 02/26/25 (mac): now available at NERSC without a module
module load cmake

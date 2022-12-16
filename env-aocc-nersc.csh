if ( "$NERSC_HOST" == "perlmutter" ) then
  module load PrgEnv-aocc
  # TODO: use Spack to generate module on Perlmutter
  export EIGEN_DIR=/global/common/software/m2032/shared/common/eigen3/3.4.0
endif

if ( "$NERSC_HOST" == "cori" ) then
  exit 1
endif

module load spectra
module load boost-mpi
module load gsl
module load python
module load parallel
module load cmake

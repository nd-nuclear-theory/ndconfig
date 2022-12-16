if [[ "$NERSC_HOST" == "perlmutter" ]]; then
  module load PrgEnv-gnu
  # TODO: use Spack to generate module on Perlmutter
  export EIGEN3_DIR=/global/common/software/m2032/shared/common/eigen3/3.4.0
fi

if [[ "$NERSC_HOST" == "cori" ]]; then
  export MODULEPATH=/global/common/software/m2032/shared/modulefiles:$MODULEPATH

  module -s swap PrgEnv-intel PrgEnv-gnu
  module switch gcc/9.3.0
  module unload cray-libsci
  module load craype-hugepages2M
  module load eigen3
fi

module load spectra
module load boost-mpi
module load gsl
module load python
module load parallel
module load cmake

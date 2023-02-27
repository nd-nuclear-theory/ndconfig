if ( "$NERSC_HOST" == "perlmutter" ) then
  module load PrgEnv-gnu
  # TODO: use Spack to generate module on Perlmutter
  setenv EIGEN3_DIR /global/common/software/m2032/shared/common/eigen3/3.4.0

  ## # temporary fix until issues with custom module files resolved
  ## module load cpu
  ## module load spack
  ## spack env activate /global/common/software/m2032/shared/spack-perlmutter
  ## spack load boost%gcc
  ## # needs BOOST_ROOT to be set
endif

if ( "$NERSC_HOST" == "cori" ) then
  setenv MODULEPATH /global/common/software/m2032/shared/modulefiles:$MODULEPATH

  module -s swap PrgEnv-intel PrgEnv-gnu
  module switch gcc/9.3.0
  module unload cray-libsci
  module load craype-hugepages2M
  module load eigen3
endif

if ( "$NERSC_HOST" == "cori" ) then
  # m2032 custom module files -- not supported on perlmutter
  module load spectra
  module load boost-mpi
endif
module load gsl
module load python
module load parallel
module load cmake

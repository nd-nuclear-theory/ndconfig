setenv MODULEPATH /global/common/software/m2032/shared/modulefiles:$MODULEPATH

module -s swap PrgEnv-intel PrgEnv-gnu
module switch gcc/9.3.0
module unload cray-libsci
module load craype-hugepages2M

module load eigen3
module load spectra
module load boost
module load gsl
module load python
module load parallel
module load cmake

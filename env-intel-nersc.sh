export MODULEPATH=/global/common/software/m2032/shared/modulefiles:$MODULEPATH

module -s swap PrgEnv-gnu PrgEnv-intel

# The Intel C++ compiler has a bug with redeclaring a static variable as constexpr
# in versions before 19.1.
module -s swap intel/19.1.2.254

# Even if using the intel compiler suite, loading GCC is still required, since gcc
# is used internally by icpc.
module load gcc/9.3.0  # needed again as of 6/13/17 (pjf)

module unload cray-libsci
module load craype-hugepages2M

module load eigen3
module load spectra
module load boost
module load gsl
module load python
module load parallel

if [[ "$NERSC_HOST" == "perlmutter" ]]; then
  return 1
fi

export MODULEPATH=/global/common/software/m2032/shared/modulefiles:$MODULEPATH

module -s swap PrgEnv-gnu PrgEnv-intel

# The Intel C++ compiler has a bug with redeclaring a static variable as constexpr
# in versions before 19.1.
module -s swap intel/19.1.2.254

# # Even if using the intel compiler suite, loading GCC is still required, since gcc
# # is used internally by icpc.
# module load gcc/8.3.0  # https://bit.ly/2Yw7TFd (pjf 211007)

# More precisely, it appears icpc is only compatible with older libstdc++
# headers, and it is tricked into finding them by setting an older GCC compiler
# path... (mac 220317)
#
# But loading the older gcc module now breaks other executables' linkage (e.g., emacs)...
#
# Instead consider adding compiler/linker flags:
#
#   -gxx-name=/opt/gcc/8.3.0/bin/g++
#   -gcc-name=/opt/gcc/8.3.0/bin/gcc
#   -Wl,-rpath=/opt/gcc/8.3.0/snos/lib64/
#
# https://bitbucket.org/berkeleylab/upcxx/wiki/docs/alt-compilers#markdown-header-intel (mac 03/17/22)

module unload cray-libsci
module load craype-hugepages2M

module load eigen3
module load spectra
module load boost-mpi
module load gsl
module load python
## module load parallel  # 02/26/25 (mac): now available at NERSC without a module
module load cmake

# NDCRC  environment file for use with gnu compilers
#
# 05/21/26 (mac): Update to current modules and new group directory.

# compiler/MPI/boost
module load ompi/5.0.9/intel/25.3
module load boost/1.91/intel/25.3

# GSL
# 05/21/26: gsl module definitions are not sufficient to support cmake
#    "Could NOT find GSL (missing: GSL_INCLUDE_DIR GSL_LIBRARY GSL_CBLAS_LIBRARY)"
# This appears to be since module sets GSL_DIR, while CMake only recognizes GSL_ROOT_DIR.
# https://cmake.org/cmake/help/latest/module/FindGSL.html
module load gsl/gcc/2.8
setenv GSL_ROOT_DIR $GSL_DIR 

# MKL -- intel module provides accesss to MKL
# loaded above as part of ompi module load

# Eigen -- 3.4.1 installed manually
#   with structure $EIGEN_DIR/include/eigen3/Eigen/
setenv EIGEN3_DIR /groups/mcaprio/opt/eigen-3.4.1

# Spectra -- to be reinstalled
## setenv SPECTRA_DIR /groups/mcaprio/opt/spectra

# tools
## module load python
module load cmake
module load parallel

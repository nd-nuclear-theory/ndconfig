# NDCRC  environment file for use with gnu compilers
#
# 05/21/26 (mac): Update to current modules and new group directory.

# compiler/MPI/boost
module load ompi/5.0.9/gcc/11.5.0
module load boost/1.91/gcc/11.5.0

# GSL
# 05/21/26: gsl module definitions are not sufficient to support cmake
#    "Could NOT find GSL (missing: GSL_INCLUDE_DIR GSL_LIBRARY GSL_CBLAS_LIBRARY)"
# This appears to be since module sets GSL_DIR, while CMake only recognizes GSL_ROOT_DIR.
# https://cmake.org/cmake/help/latest/module/FindGSL.html
module load gsl/gcc/2.8
#export GSL_DIR=/software/g/gsl/2.8/gcc/11.5.0/lib:/software/g/gsl/2.8/gcc/11.5.0/include:/software/g/gsl/2.8/gcc/11.5.0/bin:/software/g/gsl/2.8/gcc/11.5.0/
export GSL_ROOT_DIR=$GSL_DIR 

# MKL -- intel module provides accesss to MKL
module load intel/25.3
export  LD_LIBRARY_PATH=/opt/crc/i/intel/25.3/2025.3/lib/
# Eigen -- 3.4.1 installed manually
#   with structure $EIGEN_DIR/include/eigen3/Eigen/
export EIGEN3_DIR=/groups/mcaprio/opt/eigen-3.4.1

# Spectra -- to be reinstalled
## export SPECTRA_DIR=/groups/mcaprio/opt/spectra
#export PYTHONPATH=$HOME/.local/lib/python3.12/site-packages:$HOME/.local/lib/python3.12/site-packages/more_itertools:$PYTHONPATH
# tools
export LD_LIBRARY_PATH=/software/g/gsl/2.8/gcc/11.5.0/lib:/software/p/python/3.12.13/gcc/11.5.0/lib:/software/t/tcltk/8.6.17/lib:/common/lib:/opt/crc/usr/local/lib:$LD_LIBRARY_PATH
export NCCI_LIBRARY_PATH=$MCSCRIPT_WORK_HOME
module load tcl/8.6.17
module load python
module load cmake
module load parallel

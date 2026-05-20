# NDCRC  environment file for use with gnu compilers
#
# 05/20/26 (mac): Update to current modules and new group directory.

# compiler and libraries
module load gcc/15.2.0 
module load ompi/5.0.9/gcc/11.5.0
module load boost/1.91/gcc/11.5.0
module load gsl/gcc/2.8

# Eigen -- 3.4.1 installed manually
#   with structure $EIGEN_DIR/include/eigen3/Eigen/
setenv EIGEN3_DIR /groups/mcaprio/opt/eigen-3.4.1

# Spectra -- to be reinstalled
## setenv SPECTRA_DIR /groups/mcaprio/opt/spectra

# tools
module load python/3.14.5
module load cmake
module load parallel

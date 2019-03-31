setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.2.10
setenv SPECTRA_DIR /afs/crc.nd.edu/group/nuclthy/opt/spectra

# ndcrc gnu setup as of 180206
#
# gcc/7.1.0
#
# ompi/2.1.1-gcc-7.1.0
#   module load     gcc/7.1.0
#
# boost/gcc/1.66
#   module load     gcc/7.1.0
#   module load     ompi/2.1.1-gcc-7.1.0
#   module-whatis   Boost libraries compiled with GCC 7.1 and OpenMPI 2.1.1.
#
# gsl/2.3 -- TO UPDATE
#   setenv          GSL_DIR /opt/crc/g/gsl/2.3/gcc/4.8.5
#
# python/3.6.0 -- TO UPDATE
#   module load     gcc/6.2.0

module load gcc/7.1.0
module load ompi/2.1.1-gcc-7.1.0
module load boost/gcc/1.66
module load gsl/gcc/2.4
module load python/3.6.4

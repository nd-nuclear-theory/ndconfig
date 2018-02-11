setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.2.10
setenv SPECTRA_DIR /afs/crc.nd.edu/group/nuclthy/opt/spectra-0.5.0

# ndcrc intel setup as of 180206
#
# intel/17.1 (default)
#   setenv          MKLROOT /opt/crc/i/intel/17.1/mkl
#
#   Although intel/18.0 is available, beware OpenMP reduce bug.
#
# ompi/2.1.1-intel-17.1
#   module load     intel/17.1
#
# boost/intel/1.66
#   conflict        boost
#   module load     intel/17.1
#   module load     ompi/2.1.1-intel-17.1
#   module-whatis   Boost libraries compiled with Intel 17.1 and OpenMPI 2.1.1.
#
# gsl/2.3 -- TO UPDATE
#   setenv          GSL_DIR /opt/crc/g/gsl/2.3/gcc/4.8.5
#
# python/3.6.0 -- TO UPDATE
#   module load     gcc/6.2.0


module load intel/17.1
module load ompi/2.1.1-intel-17.1
module load boost/intel/1.66
module load gsl/2.3
module load python/3.6.0
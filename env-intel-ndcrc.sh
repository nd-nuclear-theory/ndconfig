export EIGEN3_DIR=/afs/crc.nd.edu/group/nuclthy/opt/eigen-3.3.7
export SPECTRA_DIR=/afs/crc.nd.edu/group/nuclthy/opt/spectra

# ndcrc intel setup as of 200924
#
# intel/19.0 
#   export          MKLROOT /opt/crc/i/intel/19.0/mkl
#
#    intel/18.0 is default, beware OpenMP reduce bug.
#
# ompi/4.0.1/intel/19.0
#   module load     intel/19.0
#
# boost/1.72/gcc/8.3.0
#   module load     gcc/8.3.0
#
# gsl/gcc/2.5
#   export          GSL_DIR /opt/crc/g/gsl/2.5/gcc
#
# python/3.7.3
#   module load     gcc/8.3.0


module load intel/19.0
module load ompi/4.0.1/intel/19.0
module load boost/1.72/gcc/8.3.0
module load gsl/gcc/2.5
module load python/3.7.3

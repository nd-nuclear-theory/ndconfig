export EIGEN3_DIR=/afs/crc.nd.edu/group/nuclthy/opt/eigen-3.3.7
export SPECTRA_DIR=/afs/crc.nd.edu/group/nuclthy/opt/spectra

# ndcrc intel setup as of 200918
#
# boost/intel/1.66 (old comment)
#   conflict        boost
#   module load     intel/17.1
#   module load     ompi/2.1.1-intel-17.1
#   module-whatis   Boost libraries compiled with Intel 17.1 and OpenMPI 2.1.1.

module load intel/19.0
module load ompi/4.0.1/intel/19.0
module load boost/1.72/gcc/8.3.0
module load gsl/gcc/2.5
module load python/3.7.3

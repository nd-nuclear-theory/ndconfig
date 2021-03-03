export EIGEN3_DIR=/afs/crc.nd.edu/group/nuclthy/opt/eigen-3.3.7
export SPECTRA_DIR=/afs/crc.nd.edu/group/nuclthy/opt/spectra

# ndcrc gnu setup as of 180206
#
# gcc/8.3.0
#
# ompi/4.0.1/gcc/8.3.0
#   module load     gcc/8.3.0
#
# boost/1.72/gcc/8.3.0
#   module load     gcc/8.3.0
#
# gsl/2.3 -- TO UPDATE
#   export          GSL_DIR /opt/crc/g/gsl/2.5/gcc
#
# python/3.6.0 -- TO UPDATE
#   module load     gcc/6.2.0

module load gcc/8.3.0
module load ompi/4.0.1/gcc/8.3.0
module load boost/1.72/gcc/8.3.0
module load gsl/gcc/2.5
module load python/3.7.3
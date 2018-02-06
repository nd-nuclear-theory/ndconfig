echo "****************************************************************"
echo "module-load-ndcrc.csh is deprecated."
echo 
echo "Please load either env-gnu-ndcrc.csh or env-intel-ndcrc.csh."
echo "Or the bash version if you must..."
echo "Not meaning to bash bash..."
echo "****************************************************************"

setenv EIGEN3_DIR /afs/crc.nd.edu/group/nuclthy/opt/eigen-3.2.10
setenv SPECTRA_DIR /afs/crc.nd.edu/group/nuclthy/opt/spectra-0.5.0
module load gcc/6.2.0
module load gsl/1.16
module load boost/1.63
module load ompi/2.0.1-gcc-6.2.0
module load python/3.6.0

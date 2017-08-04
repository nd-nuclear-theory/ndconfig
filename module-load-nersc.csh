module load eigen3  # NERSC module is at version 3.3.3 as of 6/19/17 (pjf)
## setenv EIGEN3_DIR /global/project/projectdirs/m2032/opt/eigen-3.2.10
setenv SPECTRA_DIR /global/project/projectdirs/m2032/opt/spectra-0.5.0
module unload cray-libsci
module load craype-hugepages2M
module load boost
module load gsl
module load python/3.5-anaconda
module load gcc  # needed again as of 6/13/17 (pjf)

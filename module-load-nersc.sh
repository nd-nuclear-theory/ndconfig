## module load eigen3  # NERSC module is at version 3.3.3 as of 6/19/17 (pjf)
## export EIGEN3_DIR=/global/project/projectdirs/m2032/opt/eigen-3.2.10
export SPECTRA_DIR=/global/project/projectdirs/m2032/opt/spectra-0.5.0
module unload cray-libsci
if [ "$NERSC_HOST" == "cori" ]
then
module load craype-hugepages2M
fi
module load boost
module load gsl
module load python/3.5-anaconda
module load gcc  # needed again as of 6/13/17 (pjf)

# 09/12/2017 (pjf): Fix for edison CRAY_CPU_TARGET by reloading craype-ivybridge
if [ "$NERSC_HOST" == "edison" ] && [[ -z ${GLOBUS_GRAM_JOB_CONTACT+x} ]]
then
  module load craype-ivybridge
fi


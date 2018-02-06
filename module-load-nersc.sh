echo "****************************************************************"
echo "module-load-nersc.sh is deprecated."
echo 
echo "Please load either env-gnu-nersc.sh or env-intel-nersc.sh."
echo "Or the bash version if you must..."
echo "Not meaning to bash bash..."
echo "****************************************************************"

# different module names for eigen 3.3.3 on edison and cori as of 9/12/17 (mac)
if [[ ${NERSC_HOST} == "edison" ]]; then
   module load eigen
   export EIGEN3_DIR=${EIGEN_DIR}
elif [[ ${NERSC_HOST} == "cori" ]]; then
   module load eigen3
fi
export SPECTRA_DIR=/global/project/projectdirs/m2032/opt/spectra-0.5.0
module unload cray-libsci
module load craype-hugepages2M
module load boost
module load gsl
module load python/3.6-anaconda-4.4
module swap intel/18.0.0.128 intel/17.0.3.191 # 12/21/17 (pjf): intel version 18 has openmp bug
module load gcc  # needed again as of 6/13/17 (pjf)

# 09/12/2017 (pjf): Fix for edison CRAY_CPU_TARGET by reloading craype-ivybridge
if [ "$NERSC_HOST" == "edison" ] && [[ -z ${GLOBUS_GRAM_JOB_CONTACT+x} ]]
then
  module load craype-ivybridge
fi


if [[ ($NERSC_HOST == "edison") && ($CRAY_CPU_TARGET == "sandybridge") ]]; then
   # 9/12/17 (mac): fix erroneous default architecture sandybridge by reloading craype-ivybridge
   module load craype-ivybridge
fi

# different module names for eigen 3.3.3 on edison and cori as of 9/12/17 (mac)
if [[ $NERSC_HOST == "edison" ]]; then
   module load eigen
   export EIGEN3_DIR=${EIGEN_DIR}
elif [[ $NERSC_HOST == "cori" ]]; then
   module load eigen3
fi
## export EIGEN3_DIR=/global/project/projectdirs/m2032/opt/eigen-3.2.10
export SPECTRA_DIR=/global/project/projectdirs/m2032/opt/spectra

module unload cray-libsci
module load craype-hugepages2M
module load boost/1.70.0
module load gsl
module load python/3.6-anaconda-4.4
module load gcc  # needed again as of 6/13/17 (pjf)
module switch intel/19.0.0.117 # 12/21/17 (pjf): intel version 18 has openmp bug

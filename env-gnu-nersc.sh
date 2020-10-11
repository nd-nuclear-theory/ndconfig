export MODULEPATH=/global/common/software/m2032/shared/modulefiles:$MODULEPATH

module load eigen3
export SPECTRA_DIR=/global/project/projectdirs/m2032/opt/spectra

module -s swap PrgEnv-intel PrgEnv-gnu
module unload cray-libsci
module load craype-hugepages2M
module load boost
module load gsl
module load python
module load parallel
## module swap intel/18.0.0.128 intel/17.0.3.191 # 12/21/17 (pjf): intel version 18 has openmp bug
## module load gcc  # needed again as of 6/13/17 (pjf)

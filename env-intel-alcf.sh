module use /projects/NucStructReact_6/nd-modules/modulefiles

module unload cray-libsci
module load eigen3
module load craype-hugepages2M
module load cray-python/3.8.2.1
module load boost/intel/1.73.0
module load gsl
module load gcc  # needed again as of 6/13/17 (pjf)

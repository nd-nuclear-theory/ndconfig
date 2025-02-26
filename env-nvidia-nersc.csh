if ( "$NERSC_HOST" == "perlmutter" ) then

    # basic environment for compiling mfdn GPU version
    # based on README.md in port_GPU_ACC commit db2400a 07/13/2023
    module swap PrgEnv-gnu PrgEnv-nvidia    
    module load cudatoolkit
    module load craype-accel-nvidia80
    module load libfabric
    # module unload darshan
    
endif

# need python for scripting
module load python
# parallel: for use in mcscript config-slurm-nersc.py
## module load parallel  # 02/26/25 (mac): now available at NERSC without a module

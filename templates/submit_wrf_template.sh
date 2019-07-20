#!/bin/bash
#SBATCH --ntasks=72
#SBATCH --time=04:00:00
#SBATCH --job-name=WRF_REAN_YY1MM1DD1
#SBATCH --account=wfip

module purge
module load intel-mpi/2018.0.3
module load netcdf-f/4.4.4
module load netcdf-c/4.6.2/intel-18.0.3-mpi
module load hdf5/1.10.4/intel1803-impi
export NETCDF=$NETCDF_FORTRAN
export HDF5=$HDF5_ROOT_DIR

srun -n 72 ./wrf.exe

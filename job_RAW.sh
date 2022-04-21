#!/bin/bash
#SBATCH --job-name=
#SBATCH --nodes=
#SBATCH --ntasks-per-node=
#SBATCH --output=slurm-%x.out
#SBATCH --mail-user=
#SBATCH --mail-type=


PROJECT_NAME=


# PURGE AND LOAD MODULES (AS SUGGESTED BY THE WORKLOAD MANAGER)

module purge
module load intel/19.1.3
module load intel-mpi/2021.1.1



# WRITE AUXILLIARY INFORMATION

echo
echo "Running on $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "CURRENT WORKING DIRECTORY IS `pwd`"
echo "START: `date`"
echo


# SET PROJECT DIRECTORY AND NIRVANA SOURCE / COMPILE THE CODE

NIRVANA_HOME=$HOME/NIRVANA-master

cd $NIRVANA_HOME/nirvana/bin
./makeNIRVANA /nirvana/projects/$PROJECT_NAME



# CLEAR AND READY RUN DIRECTORY (LOCATED IN THE $DATA-TREE FOR STORAGE)

cd $DATA/RAW
rm -r $SLURM_JOB_NAME
mkdir $SLURM_JOB_NAME



# RUN NIRVANA INSIDE RUN DIRECTORY (COPY NECESSARY FILES AND USE srun) / INITIALIZE MPI LIB

cd $SLURM_JOB_NAME
cp $NIRVANA_HOME/nirvana/bin/NIRVANA.exe .
cp $NIRVANA_HOME/nirvana/projects/$PROJECT_NAME/nirvana.par .
cp $NIRVANA_HOME/nirvana/projects/$PROJECT_NAME/NCCM.par .
cp -r $NIRVANA_HOME/nirvana/projects/$PROJECT_NAME/dbNCCM .
cp -r $NIRVANA_HOME/nirvana/projects/$PROJECT_NAME $DATA/RAW/$SLURM_JOB_NAME/

export I_MPI_PMI_LIBRARY=/opt/vsc4/slurm/18-08-7-1/lib/libpmi.so

echo 
echo "STARTING $PROJECT_NAME"
echo 
srun $DATA/RAW/$SLURM_JOB_NAME/NIRVANA.exe



# MAKE SURE TO INCLUDE TO SLURM-OUTPUT TO POSSIBLY MONITOR RESULT

cd $HOME
cp slurm-$SLURM_JOB_NAME.out $DATA/RAW/$SLURM_JOB_NAME/



# END BY PRINTING END TIME TO MONITOR WALLTIME

echo
echo "END: `date`"
echo "DONE"

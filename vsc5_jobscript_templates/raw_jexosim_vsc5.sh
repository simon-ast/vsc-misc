#!/bin/bash
#
#SBATCH --account=p70652
#SBATCH --partition=zen3_0512
#SBATCH --qos=p71867_0512
#
#SBATCH -J 
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-core=1
#SBATCH --output=slurm-%x.out
#
#SBATCH --time=01-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=simon.schleich@univie.ac.at


# USER INPUTS
RUNFILE_NAME=
STORAGE_NAME=
OVERWRITE=no

#######################################################
# Do not forget to give the job a name in the header. #
#                                                     #
# RUNFILE_NAME should be the parameter file located   #
# in the JexoSim input_file directory.                #
#                                                     #
# STORAGE_NAME should be the desired folder name in   #
# the JexoSim_Outputs folder.                         #
#                                                     #
# OVERWRITE can be ingored for now.                   #
#######################################################


#########################################
#    AMATEUR BASH-SCRIPTING AND         #
#        SLURM-HANDLING AHEAD.          #
#    MOVE BELOW AT YOUR OWN RISK!       #
#########################################

# SLURM HOUSEKEEPING, EXECUTION GLOBALS AND STORAGE
JEXOSIM_DIR=$DATA/JexoSim
module purge

# make sure to recognise that the output folder might exist
if [ -d "$DATA/JexoSim_Outputs/$STORAGE_NAME" ]; then
  if [ "$OVERWRITE" != "yes" ]; then
    echo && echo "Overwrite was not allowed!" && echo
    exit
  fi
fi

rm -r $DATA/JexoSim_Outputs/$STORAGE_NAME
mkdir $DATA/JexoSim_Outputs/$STORAGE_NAME


# WRITE AUXILLIARY INFORMATION
echo
echo "Running on $SLURM_NODELIST"
echo "Running on $SLURM_NNODES nodes."
echo "Running on $SLURM_NPROCS processors."
echo "START: `date`"
echo


# PREPARE AND EXECUTE CODE HERE
cd $JEXOSIM_DIR
python3 run_jexosim.py $RUNFILE_NAME


# MOVE RESULTS TO CORRECT FOLDER
cd output
mv *.pickle $DATA/JexoSim_Outputs/$STORAGE_NAME
mv *.pickle.txt $DATA/JexoSim_Outputs/$STORAGE_NAME

# MOVE SLURM OUTPUT ALSO INTO THE RESULTS FOLDER
cd $HOME
cp slurm-$SLURM_JOB_NAME.out $DATA/JexoSim_Outputs/$STORAGE_NAME

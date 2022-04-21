#!/bin/bash

# Script that runs the caivs data conversion tool
module load intel/19.1.3
CAIVS_DIR=/home/fs70652/sschleich/NIRVANA-master/caivs
RUN_DIR=/home/fs70652/sschleich/NIRVANA-master/bin

cd $DATA/RAW

echo
echo "RESULT FOLDERS:"
tree -L 1
echo

while true
do
  	read -p "ENTER FOLDER [NAME]? " answer

	if [ "$answer" == "n" ]; then
		exit;
	else
		cd $answer
		echo

		# Gives total number of processes used
		echo "Number of processes used = $(ls -l NIR0*  | grep -v ^d | wc -l)"
		echo `ls NIR0.*`
		echo
	
		# Gives step size and number of steps
		echo "Read step size from the differences in these files"
		echo `ls *.1 | tail -5`
		echo
	
		# Names the result folder that is packaged with the .SILO files
                read -p "PROCEED? " name
                echo
                break
	fi
done

# Edit the caivs parameter file to the correct data input and step size values
nano $CAIVS_DIR/caivs.par


cd $HOME/NIRVANA-master/viz
rm -r *

shopt -s extglob
cd $DATA/RAW/$answer
cp -r !(NIR*) $HOME/NIRVANA-master/viz

sleep 2

cd $CAIVS_DIR/bin
./makeCAIVS
echo

sleep 2

cd $RUN_DIR
./runCAIVS

sleep 2

while pidof CAIVS.exe;		# Holds the process until CAIVS is finished (no longer a process ID present)
	do sleep 5		# prints PID, a bit annoying
	
	done;

cd $HOME/NIRVANA-master/viz

zip -r $answer.zip *
cp $answer.zip $DATA/CAIVS
mv $answer.zip $HOME

echo
echo "DONE"
echo

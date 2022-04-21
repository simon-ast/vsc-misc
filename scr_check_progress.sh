#!/bin/bash

# Script that checks the last few lines of the nirvana log-file to monitor
# wall time, progress etc


cd $DATA/RAW

echo
echo "RESULT FOLDERS:"
echo 
tree -L 1
echo 

while true
do
	read -p "Which result should be handled? " folder
	cd $folder
	
	tail -40 nirvana.log
	exit;
done

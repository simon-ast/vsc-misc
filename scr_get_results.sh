#!/bin/bash

# Script to package the results of a particular simulation run

cd $DATA

echo
echo "RESULT FOLDERS:"
echo 
tree -L 1
echo 

while true
do
	read -p "Which result should be packaged? " folder
	
	cd $DATA
	cp -r $folder temporary_folder
	tar -czf $folder.tar.gz temporary_folder/
	mv $folder.tar.gz $HOME	
	rm -r temporary_folder/

	exit;
done

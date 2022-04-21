#!/bin/bash

# Move into the root directory of users on these nodes
cd ..

# FOR-LOOP over all users
for user in $(ls)
	do
		# Echo the user name first for readability
		echo "$user"
	
		# Put double-quotes (") to preserve line-structure of command output
		echo "$(squeue -u $user)"
		echo
	done

cd $HOME

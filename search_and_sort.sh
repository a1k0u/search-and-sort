#!/bin/bash

if [[ -n $1 ]]; then
	cd $1
	echo "Are you sure to start sort in `pwd`? [yes\no]"

	read user_answer
	if [[ $user_answer[] == "no" || "$user_answer" == "n" ]]; 
	then
		exit
	fi
else
	echo "Enter your file path as an argument!"
	exit
fi

for element in `ls $1`
do
	echo $element
done
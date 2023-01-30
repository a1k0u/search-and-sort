#!/bin/bash

: '
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
'

function get_extention() {
  echo ${1#*.}
}

PATH_FROM=$1
PATH_TO=$2

ELEMENTS=( $(ls $PATH_FROM) )

for element in ${ELEMENTS[@]}
do
  extention=$(get_extention $element)
  
  EXTENTION_DIRECTORY="$PATH_TO/$extention" 
  if [ ! -d $EXTENTION_DIRECTORY]
  then
    mkdir $EXTENTION_DIRECTORY
  fi
  
  cp "$PATH_FROM/$element" $EXTENTION_DIRECTORY
done

# Search into directories?
# Validation paths
# Name ocupations ?
# ...


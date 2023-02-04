#!/bin/bash

function get_extention() {
  # Gets file extentions, using powerful of POSIX.

  echo ${1##*.}
}

# Get files from.
PATH_FROM=$1

# Move or copy files to.
PATH_TO=$2

# If no folders then will work in work directory.
if [[ -z "$PATH_FROM" ]]; then
    PATH_FROM=$(pwd)
fi

if [[ -z "$PATH_TO" ]]; then
    PATH_TO=$(pwd)
fi

# Validating paths.
if [[ ! -e "$PATH_FROM" || ! -e "$PATH_TO" ]]; then
	echo "Some of the paths does not exist! :("
	exit -1
fi

# Array of elements with small hack.
# Hack: 'some name of file.png',
# we will use prohibited symbol '/' to concat in array.
elements=( $(ls -U $PATH_FROM | tr " " "/") )

for element in ${elements[@]}; do
	# Returns name back.
	standart_name=$(echo $element | tr "/" " ")
	element_path="$PATH_FROM/$standart_name"
	
	extention=$(get_extention "$element")

	# If no extention then skips iteration.
	if [[ -d "$element_path" || ${#extention} == ${#element} ]]; then
		continue
	fi

	extention_directory="$PATH_TO/$extention"

	# Creates folder if it need.
	if [ ! -d "$extention_directory" ]; then
		mkdir "$extention_directory"
	fi
	
	# Move file.
	mv --backup=numbered "$element_path" "$extention_directory"

	# Verbose results.
	echo -en "\033[9;31m$element_path\033[29m\033[3;32m 
	  -> \033[4;37m$extention_directory\033[0m\n"
done

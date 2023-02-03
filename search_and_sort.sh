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
	PATH_To=$(pwd)
fi

# Validating paths.
if [[ ! -e "$PATH_FROM" || ! -e "$PATH_TO" ]]; then
	echo "Some of the paths does not exist! :("
	exit
fi

# Array of elements with small hack.
# Hack: 'some name of file.png',
# we will use prohibited symbol '/' to concat in array.
ELEMENTS=( $(ls $PATH_FROM | tr " " "/") )

for element in ${ELEMENTS[@]}; do
	extention=$(get_extention "$element")

	# If no extention then skips iteration.
	if [[ ${#extention} == ${#element} ]]; then
		continue
	fi

	EXTENTION_DIRECTORY="$PATH_TO/$extention"

	# Creates folder if it need.
	if [ ! -d "$EXTENTION_DIRECTORY" ]; then
		mkdir "$EXTENTION_DIRECTORY"
	fi

	# Returns name back.
	standart_name=$(echo $element | tr "/" " ")
	ELEMENT_PATH="$PATH_FROM/$standart_name"
	
	# Move file.
	mv "$ELEMENT_PATH" "$EXTENTION_DIRECTORY"

	# Verbose results.
	echo -en "\033[9;31m$ELEMENT_PATH\033[29m\033[3;32m -> \033[4;37m$EXTENTION_DIRECTORY\033[0m\n"
done

# TODO:
# 0) Name ocupations ? in move? fix
# 1) ask user to start
# 2) unfolder script
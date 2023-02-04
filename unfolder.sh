#!/bin/bash

function unfolder() {
    # $1 - recursion level.
    # $2 - current path.

    # If recursion level is reached then returns.
    if [[ $1 == -1 ]]; then
        return
    fi

    # Get elements in current path.
    local elements=( $(ls -U "$2") )
    
    for element in ${elements[@]}; do
        # Create element path.
        local element_path="$2/$element"

        # If element is folder then recursive call.    
        if [[ -d "$element_path" ]]; then 
            unfolder $(( $1 - 1 )) "$element_path"
            continue
        fi

        # Processing files.
        mv --backup=numbered "$element_path" "$PATH_TO"
        
        # Verbose results.
	    printf "%b" "\e[9;31m$element_path\e[29m\e[3;32m 
	        -> \e[4;37m$PATH_TO\e[0m\n"
    done
}

# Get parameters.
RECURSION_LEVEL=$1
PATH_FROM=$2
PATH_TO=$3

# If not recursion level then sets 1.
if [[ "$RECURSION_LEVEL" =~ "^[0-9]+" ]]; then
    echo "Value of recursion level is incorrect!"
    exit -1
fi

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

unfolder $RECURSION_LEVEL "$PATH_FROM"

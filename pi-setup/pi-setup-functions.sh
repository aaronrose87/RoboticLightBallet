#!/bin/bash

# If there's not already a preserved file ending in .orig
# make one by renaming.
PRESERVE() {
    if [[ ! -f ${1}.orig ]] ; then
        echo "Preserving ${1} to ${1}.orig"
        mv ${1} ${1}.orig
    else
        echo "Already preserved: ${1}.orig"
    fi
}

# If there's a preserved file, make a fresh copy of it
# in its original place
FRESH() {
    if [[ -f ${1}.orig ]] ; then
        echo "Making fresh copy of ${1}.orig to ${1}"
        cp ${1}.orig ${1}
    fi
}

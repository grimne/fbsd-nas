#!/bin/sh

VERSION=0.2-devel

# get libs
if [ -e "./lib/nas-cmd" ]; then
    LIB="./lib"
elif [ -e "/usr/local/lib/fbsd-nas" ]; then
    LIB="/usr/local/lib/fbsd-nas"
else
    echo "unable to locate fbsd-nas libraries"
    exit 1
fi

# load libs
. "${LIB}/nas-cmd"
. "${LIB}/nas-util"

. "${LIB}/nas-disk"
. "${LIB}/nas-encryption"
. "${LIB}/nas-zpool"
# . "${LIB}/nas-zfs"


# check informational commands
cmd::parse_info "$@"

# run the requested command
cmd::parse "$@"

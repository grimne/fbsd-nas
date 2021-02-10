#!/bin/sh

_lib_dest="/usr/local/lib/fbsd-nas"
_bin_dest="/usr/local/bin/nas"
LIB="./lib"

. "${LIB}/nas-util"

nas::install(){
    cp -rv $LIB $_lib_dest
    chmod -R 755 $_lib_dest

    cp -v nas $_bin_dest
    chmod 755 $_bin_dest

    exit 0
}

nas::deinstall(){
    rm -rf $_lib_dest
    rm -rf $_bin_dest
}

nas::reinstall(){
    nas::deinstall
    nas::install
}

if [ -e "${_lib_dest}" ]; then
    util::confirm "It appears you already have an installation. Reinstall?" || exit 0
    nas::reinstall 
else
    util::confirm "You are about to install fbsd-nas utility on to your system. Cool?" || exit 0
    nas::install
fi

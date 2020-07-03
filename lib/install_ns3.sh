#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

install_dir="/usr/local/share/ns-3/"
ns3_ver="3.30"

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit; pwd)
cd "$SCRIPT_DIR" || exit

unameOut="$(uname -a)"
IS_CYGWIN=""
IS_MAC=""
IS_LINUX=""
IS_UBUNTU=""
case "$unameOut" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Darwin*) echo "##this is macos" && IS_MAC=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac
case "$unameOut" in
	*Ubuntu*) echo "##this is Ubuntu" && IS_UBUNTU=true;;
esac
## check Windows Subsystem for Linux
[ -e /proc/sys/fs/binfmt_misc/WSLInterop ] && IS_UBUNTU=true


sudo install_ns3_pkgs.sh

#PACKAGES=(cxxfilt)
#python3 -m pip install --user cxxfilt

if [ $IS_UBUNTU ]; then
    if [ ! -e "$install_dir" ]; then
        echo "$install_dir not exist. create dir"
        mkdir -p "$install_dir" || exit
    fi
fi

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

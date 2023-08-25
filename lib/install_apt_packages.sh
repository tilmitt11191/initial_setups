#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR


unameOut="$(uname -s)"
IS_CYGWIN=""
IS_MAC=""
IS_LINUX=""
case "${unameOut}" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Darwin*) echo "##this is macos" && IS_MAC=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

if [ $IS_LINUX ]; then
	PACKAGES=(zsh vim tree git curl ssh autossh tmux xclip gparted exfat-fuse exfat-utils net-tools golang aptitude ubuntu-restricted-extras)
	for package in ${PACKAGES[@]}; do
		dpkg -l $package | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt-get install -y $package."
			echo "$m"
			sudo apt install -y $package
		else
			m="$package already installed."
			echo "$m"
		fi
	done
	systemctl start sshd
	
elif [ $IS_CYGWIN ]; then
#apt-cyg install git make gcc-g++ mingw64-x86_64-gcc-g++ python3-pip
	:
fi




cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

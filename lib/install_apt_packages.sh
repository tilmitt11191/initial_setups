#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


PACKAGES=(zsh vim git curl autossh tmux xclip gparted exfat-fuse exfat-utils net-tools golang aptitude)
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

#apt-cyg install git make gcc-g++ mingw64-x86_64-gcc-g++



cd $INITIALDIR
exit 0

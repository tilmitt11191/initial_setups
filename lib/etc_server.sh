#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

unameOut="$(uname -s)"
IS_CYGWIN=""
IS_LINUX=""
case "${unameOut}" in
	CYGWIN*)  IS_CYGWIN=true;;
	Linux*) IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

if [ $IS_LINUX ]; then
	echo "##install server applications for LINUX start"
	PACKAGES=(openssh-server net-tools)
	for package in ${PACKAGES[@]}; do
		dpkg -l $package | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt -y install $package."
			echo "$m"
			sudo apt -y install $package
		else
			m="$package already installed."
			echo "$m"
		fi
	done


fi

if [ $IS_CYGWIN ]; then
	echo "in progress. exit 1"
	exit 1
fi




cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

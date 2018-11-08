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

echo "##apt update"
sudo apt -y update > /dev/null 2>&1 && sudo apt -y dist-upgrade > /dev/null 2>&1 

if [ $IS_LINUX ]; then
	echo "##install docker for LINUX start"

	PACKAGES=(apt-transport-https ca-certificates curl software-properties-common)
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

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	FINGERPRINT=`sudo apt-key fingerprint 0EBFCD88`
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test edge"

	echo "apt update & install docker-ce"
	sudo apt -y update
	sudo apt -y install docker-ce


	echo "FINGERPRINT: $FINGERPRINT"

	cd $INITIALDIR
	exit 0
fi

echo "cant install this platform(`uname -s`)"
cd $INITIALDIR
exit 1


: <<'#__CO__'
#__CO__

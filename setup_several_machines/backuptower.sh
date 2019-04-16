#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

PACKAGES=(mysql-server winbind libnss-winbind)
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

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__


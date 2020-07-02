#!/usr/bin/env bash

BASEDIR="/usr/local/share/ns-3/"

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`

unameOut="$(uname -s)"
case "${unameOut}" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Darwin*) echo "##this is macos" && IS_MAC=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is FreeBSD" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

if [ $IS_LINUX ]; then
    if [ ! -e $BASEDIR ]; then
        echo "$BASEDIR not exist. create dir"
        sudo mkdir -p $BASEDIR
    fi
fi

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

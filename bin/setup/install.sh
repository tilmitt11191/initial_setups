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
	FreeBSD*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

if [ "${IS_LINUX}" ]; then
	bash -x ubuntu_setup_1.sh
elif [ "${IS_CYGWIN}" ]; then
	echo "this is cygwin"
fi



cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

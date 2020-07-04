#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

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

echo "if ubuntu check sudo"

: <<'#__CO__'
PACKAGES=(gcc g++ python python3 python3-dev python3-setuptools git mercurial qt5-default gir1.2-goocanvas-2.0 python-gi python-gi-cairo python-pygraphviz python3-gi python3-gi-cairo python3-pygraphviz gir1.2-gtk-3.0 ipython ipython3 openmpi-bin openmpi-common openmpi-doc libopenmpi-dev uncrustify gsl-bin libgsl-dev libgsl23 libgslcblas0 sqlite sqlite3 libsqlite3-dev libxml2 libxml2-dev cmake libc6-dev libc6-dev-i386 libclang-6.0-dev llvm-6.0-dev automake pip libgtk2.0-0 libgtk2.0-dev vtun lxc libboost-signals-dev libboost-filesystem-dev doxygen graphviz imagemagick texlive texlive-extra-utils texlive-latex-extra texlive-font-utils texlive-lang-portuguese dvipng latexmk python3-sphinx dia)

if [ $IS_UBUNTU ]; then
	for package in "${PACKAGES[@]}"; do
		dpkg -l "$package" | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt install -y $package."
			echo "$m"
			apt install -y "$package"
		else
			m="$package already installed."
			echo "$m"
		fi
	done
fi
#__CO__

cd "$INITIALDIR" || exit 1
exit 0

: <<'#__CO__'
#__CO__

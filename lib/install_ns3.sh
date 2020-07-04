#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

install_dir="$HOME/program/ns-3/"
ns3_ver="3.31"

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1

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


python_path=$(which python3)
python_ver=$(python3 -V)
pip_path=$(which pip3)
echo "python_path: $python_path"
echo "python_ver: $python_ver"
echo "pip_path: $pip_path"
echo -n "Is python OK? [Y/n] default[Y]:"
read -r ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) echo "exit 1" && exit 1;;
esac

sudo bash install_ns3_pkgs.sh

PACKAGES=(cxxfilt)
for package in "${PACKAGES[@]}"; do
	pip3 install "$package"
done

if [ $IS_UBUNTU ]; then
    if [ ! -e "$install_dir" ]; then
        echo "$install_dir does not exist. create dir"
        mkdir -p "$install_dir" || echo "cannot create $install_dir. exit" && exit 1
    fi
fi

cd "$install_dir" || exit 1
mkdir workspace
cd workspace || exit 1
git clone https://gitlab.com/nsnam/ns-3-allinone.git
cd ns-3-allinone || exit 1
python3 download.py -n "ns-$ns3_ver"
mv "ns-$ns3_ver" "$install_dir/"
cd "$install_dir/ns-$ns3_ver/" || exit 1



./waf clean
./waf configure --build-profile=debug --enable-examples --enable-tests --with-pybindgen=../PyBindGen-0.20.0  --with-nsclick=../click --with-brite=../BRITE --with-openflow=../openflow
./waf build

cd "$INITIALDIR" || exit 1
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


INSTALL_RUBY_VERSION=2.7.1
DATETIME=`date +%Y%m%d%H%M`
unameOut="$(uname -s)"
IS_CYGWIN=""
IS_LINUX=""
case "${unameOut}" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac
[ $IS_CYGWIN ] && echo "this is cygwin"
[ $IS_LINUX ] && echo "this is linux"


echo "####install packages"
PACKAGES=(git libssl-dev libreadline-dev zlib1g-dev)
if [ $IS_CYGWIN ]; then
	for package in ${PACKAGES[@]}; do
		echo "install $pcakage"
		apt-cyg install $package 2>&1 >/dev/null
	done
elif [ $IS_LINUX ]; then
	for package in ${PACKAGES[@]}; do
		dpkg -l $package | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt install -y $package."
			echo "$m"
			sudo apt install -y $package
		else
			m="$package already installed."
			echo "$m"
		fi
	done
fi

echo "####install rbenv"
[ ! -d $HOME/.rbenv ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo "####install ruby-build"
[ ! -d $HOME/.rbenv/plugins/ruby-build ] && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv install $INSTALL_RUBY_VERSION
rbenv rehash
rbenv global $INSTALL_RUBY_VERSION

echo "####ruby install finished. ruby --version:"


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

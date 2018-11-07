#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


echo "####install packages"
PACKAGES=(build-essential libsm6 libxrender1)
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


echo "####install pyenv"
if [ ! -d $HOME/.pyenv ];then
	git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
echo $PATH
eval "$(pyenv init -)"

echo "####install anaconda"
ANACONDA_VER=`pyenv install -l | grep anaconda | tail -n 2 | head -n 1`
echo $ANACONDA_VER
#pyenv install $ANACONDA_VER
pyenv rehash

echo "####"

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


INSTALL_PYTHON_VERSION=3.7
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
PACKAGES=(build-essential libsm6 libxrender1)

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

echo "####install pyenv"
if [ ! -d $HOME/.pyenv ];then
	git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
fi

if [ $IS_CYGWIN ]; then
	ANACONDA_VER=anaconda3-5.3.0
	echo "####install anaconda $ANACONDA_VER"
	exec $HOME/../Downloads/$ANACONDA_VER-Windows-x86_64.exe
	echo "After finished to install Anaconda with GUI, Press any key."
	read
elif [ $IS_LINUX ]; then
	ANACONDA_VER=`pyenv install -l | grep anaconda | tail -n 2 | head -n 1 | sed -e 's/^[ ]*//'`
	echo "####install anaconda $ANACONDA_VER"
	pyenv install $ANACONDA_VER
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv rehash

[ -e $PYENV_ROOT/versions/anaconda ] && mv $HOME/.pyenv/versions/anaconda $HOME/.pyenv/versions/anaconda.$DATETIME

if [ $IS_CYGWIN ]; then
	mkdir -p $HOME/.pyenv/versions/anaconda/
	ln -s $HOME/../Anaconda3/Scripts $HOME/.pyenv/versions/anaconda/bin
	ln -s $HOME/../Anaconda3/envs $HOME/.pyenv/versions/anaconda/envs
	chmod -R +rwx $HOME/.pyenv/versions/anaconda
elif [ $IS_LINUX ]; then
	ln -s "$PYENV_ROOT/versions/$ANACONDA_VER" $PYENV_ROOT/versions/anaconda
fi

export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PATH"
chmod +x $PYENV_ROOT/versions/anaconda/bin/activate
chmod +x $PYENV_ROOT/versions/anaconda/bin/deactivate
alias activate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/activate"
alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"


echo "#### create python $INSTALL_PYTHON_VERSION as py$INSTALL_PYTHON_VERSION"
[ $IS_CYGWIN ] $HOME/../Anaconda3/Scripts/conda.exe create -ym -n  py$INSTALL_PYTHON_VERSION python=$INSTALL_PYTHON_VERSION
[ $IS_LINUX ] && conda create -ym -n  py$INSTALL_PYTHON_VERSION python=$INSTALL_PYTHON_VERSION

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

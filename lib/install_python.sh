#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


INSTALL_PYTHON_VERSION=3.7
DATETIME=`date +%Y%m%d%H%M`
IS_CYGWIN="$(uname -a | grep Cygwin)"
IS_LINUX="$(uname -a | grep Linux)"

if [ "${IS_CYGWIN}" ]; then
	echo "this is cygwin"
elif [ "${IS_LINUX}" ]; then
	echo "this is linux"
fi

exit 0


: <<'#__CO__'
echo "####install packages"
PACKAGES=(build-essential libsm6 libxrender1)

if [ "$(uname -a | grep Cygwin)" ]; then
	for package in ${PACKAGES[@]}; do
		apt-cyg install $package
	done
else
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
fi

echo "####install pyenv"
if [ ! -d $HOME/.pyenv ];then
	git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
fi

if [ "$(uname -a | grep Cygwin)" ]; then
	ANACONDA_VER=anaconda3-5.3.0
	echo "####install anaconda $ANACONDA_VER"
	exec $HOME/../Downloads/$ANACONDA_VER-Windows-x86_64.exe
else
	ANACONDA_VER=`pyenv install -l | grep anaconda | tail -n 2 | head -n 1 | sed -e 's/^[ ]*//'`
	echo "####install anaconda $ANACONDA_VER"
	pyenv install $ANACONDA_VER
fi
#__CO__

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
pyenv rehash

[ -e $PYENV_ROOT/versions/anaconda ] && mv $HOME/.pyenv/versions/anaconda $HOME/.pyenv/versions/anaconda.$DATETIME

if [ "$(uname -a | grep Cygwin)" ]; then
	mkdir -p $HOME/.pyenv/versions/anaconda/
	ln -s $HOME/../Anaconda3/Scripts $HOME/.pyenv/versions/anaconda/bin
	ln -s $HOME/../Anaconda3/envs $HOME/.pyenv/versions/anaconda/envs
	chmod -R +rwx $HOME/.pyenv/versions/anaconda
else
	ln -s "$PYENV_ROOT/versions/$ANACONDA_VER" $PYENV_ROOT/versions/anaconda
fi

export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PATH"
chmod +x $PYENV_ROOT/versions/anaconda/bin/activate
chmod +x $PYENV_ROOT/versions/anaconda/bin/deactivate
alias activate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/activate"
alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"


echo "#### create python $INSTALL_PYTHON_VERSION as my_default"
#$HOME/../Anaconda3/Scripts/conda.exe create -ym -n myenv python=3.7

conda create -ym -n myenv python=$INSTALL_PYTHON_VERSION

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

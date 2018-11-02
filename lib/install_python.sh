#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


#if linux
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


ANACONDA_VER=`pyenv install -l | grep anaconda | tail -n 2 | head -n 1 | sed -e 's/^[ ]*//'`
echo "####install anaconda $ANACONDA_VER"
pyenv install $ANACONDA_VER
pyenv rehash
ln -s "$PYENV_ROOT/versions/$ANACONDA_VER" $PYENV_ROOT/versions/anaconda
export PATH="$PYENV_ROOT/versions/anaconda/bin/:$PATH"
chmod +x $PYENV_ROOT/versions/anaconda/bin/activate
chmod +x $PYENV_ROOT/versions/anaconda/bin/deactivate
alias activate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/activate"
alias deactivate-anaconda="source $PYENV_ROOT/versions/anaconda/bin/deactivate"


echo "#### create python 3.7"
conda create -n py3.7 python=3.7 anaconda


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

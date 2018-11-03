#!/usr/bin/env zsh

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

PACKAGES=(git zsh vim)
if [ "$(uname -a | grep Ubuntu)" ]; then
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

if [ "$(uname -a | grep Cygwin)" ]; then
	for package in ${PACKAGES[@]}; do
		apt-cyg install $package
	done
fi

#git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
[ "$(uname -a | grep Cygwin)" ] && chmod -R +rwx $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cd "${ZDOTDIR:-$HOME}"/.zprezto
git pull
git submodule update --init --recursive

#FONTS_DIR=$HOME/.fonts/other_fonts/for_powerline
git clone https://github.com/powerline/fonts.git --depth=1 $HOME/tmp/fonts_for_powerline
# install
cd $HOME/tmp/fonts_for_powerline/
zsh install.sh
# clean-up a bit
rm -rf $HOME/.fonts/powerline/

cd $INITIALDIR
exit 0


: <<'#__CO__'
#__CO__

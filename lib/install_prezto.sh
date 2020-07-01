#!/usr/bin/env zsh

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`

case "${OSTYPE}" in
	cygwin*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	darwin*) echo "##this is macos" && IS_MAC=true;;
	linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is FreeBSD" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

PACKAGES=(git zsh vim)
if [ $IS_LINUX ]; then
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
elif [ $IS_CYGWIN ]; then
	for package in ${PACKAGES[@]}; do
		apt-cyg install $package
	done
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
[ $IS_CYGWIN ] && chmod -R +rwx $HOME/.zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cd "${ZDOTDIR:-$HOME}"/.zprezto
git pull
git submodule update --init --recursive

FONTS_DIR=$HOME/tmp/fonts_for_powerline
[ -d $FONTS_DIR ] && rm -rf $FONTS_DIR
git clone https://github.com/powerline/fonts.git --depth=1 $FONTS_DIR
cd $FONTS_DIR
zsh install.sh
# clean-up a bit
rm -rf $FONTS_DIR

cd $INITIALDIR
exit 0


: <<'#__CO__'
#__CO__

#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


if [ $# -ne 2 ]; then
	echo "####$(basename "$0") need 1 args."
	echo "1: DOTFILES_BACKUP. backup or no"
	echo "1: BINFILES_BACKUP. backup or no"
	exit 1
fi
DOTFILES_BACKUP=$1 # "backup" or "no"
BINFILES_BACKUP=$1 # "backup" or "no"

DATETIME=$(date +%Y%m%d_%H%M)

case "$(uname -s)" in
	cygwin*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	darwin*) echo "##this is macos" && IS_MAC=true;;
	linux*) echo "##this is Linux" && IS_LINUX=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is FreeBSD" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac


PACKAGES=(\
	git \
)
if [ "$IS_LINUX" ]; then
	echo "####install PACKAGES [${PACKAGES[*]}]"
	sudo apt update || exit 1
	for package in "${PACKAGES[@]}"; do
		dpkg -l "$package" | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt-get install -y $package."
			echo "$m"
			sudo apt install -y "$package" || exit 1
		else
			m="$package already installed."
			echo "$m"
		fi
	done
	sudo apt upgrade -y || exit 1
elif [ "$IS_CYGWIN" ]; then
	for package in "${PACKAGES[@]}"; do
		apt-cyg install "$package" || exit 1
	done
fi


if [ -e $HOME/.dotfiles ]; then
	echo "$HOME.dotfiles exists. already installed."
else
	git clone https://github.com/tilmitt11191/dotfiles $HOME/.dotfiles
fi


DOTFILES=(\
	zshrc \
	vimrc \
	vim \
	tmux.conf \
	tmux \
	zpreztorc \
	zlogout \
)
for file in "${DOTFILES[@]}"; do
	echo "create $HOME/.$file"
	[ -e "$HOME/.$file" ] || [ -L "$HOME/.$file" ] && [ "$DOTFILES_BACKUP" == "backup" ] && cp -r "$HOME/.$file" "$HOME/.$file.$DATETIME"
	[ -e "$HOME/.$file" ] || [ -L "$HOME/.$file" ] && echo "rm -rf $HOME/.$file" && rm -rf "$HOME/.$file"
	ln -s "$HOME/.dotfiles/$file" "$HOME/.$file" || exit 1
done

if [ ! $IS_CYGWIN ]; then
	DOTFILES=(\
		minttyrc \
	)
	for file in "${DOTFILES[@]}"; do
		echo "create $HOME/.$file"
		[ -e "$HOME/.$file" ] || [ -L "$HOME/.$file" ] && [ "$DOTFILES_BACKUP" == "backup" ] && cp -r "$HOME/.$file" "$HOME/.$file.$DATETIME"
		[ -e "$HOME/.$file" ] || [ -L "$HOME/.$file" ] && echo "rm -rf $HOME/.$file" && rm -rf "$HOME/.$file"
		ln -s "$HOME/.dotfiles/$file" "$HOME/.$file" || exit 1
	done
fi


[ ! -e "${HOME:?}/bin" ] && mkdir "${HOME:?}/bin/"
BINFILES=(
	activate-anaconda \
	pulldotfiles \
	pushgitfiles \
	pushgooglegit \
	rmate \
)
for file in "${BINFILES[@]}"; do
	echo "create ${HOME:?}/bin/$file"
	[ -e "${HOME:?}/bin/$file" ] || [ -L "${HOME:?}/bin/$file" ] && [ "$BINFILES_BACKUP" == "backup" ] && cp -r "${HOME:?}/bin/$file" "${HOME:?}/bin/$file.$DATETIME"
	[ -e "${HOME:?}/bin/$file" ] || [ -L "${HOME:?}/bin/$file" ] && rm -rf "${HOME:?}/bin/$file"
	ln -s "$SCRIPT_DIR/../../bin/$file" "${HOME:?}/bin/$file" || exit 1
	chmod +x "${HOME:?}/bin/$file"
done

if [ ! $IS_CYGWIN ]; then
	BINFILES=(
		st
	)
	for file in "${BINFILES[@]}"; do
		echo "create ${HOME:?}/bin/$file"
		[ -e "${HOME:?}/bin/$file" ] || [ -L "${HOME:?}/bin/$file" ] && [ "$BINFILES_BACKUP" == "backup" ] && cp -r "${HOME:?}/bin/$file" "${HOME:?}/bin/$file.$DATETIME"
		[ -e "${HOME:?}/bin/$file" ] || [ -L "${HOME:?}/bin/$file" ] && rm -rf "${HOME:?}/bin/$file"
		ln -s "$SCRIPT_DIR/../../bin/$file" "${HOME:?}/bin/$file" || exit 1
		chmod +x "${HOME:?}/bin/$file"
	done
fi
export PATH=$HOME/bin:$PATH


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

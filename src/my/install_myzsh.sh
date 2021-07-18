#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


INSTALL_PREZTO=$1  # true or false
INSTALL_PECO=$2 # true or false


case "$(uname -s)" in
	cygwin*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	darwin*) echo "##this is macos" && IS_MAC=true;;
	linux*) echo "##this is Linux" && IS_LINUX=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	FreeBSD*) echo "##this is FreeBSD" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac


PACKAGES=(\
	vim \
	zsh \
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


echo "####chsh -s /bin/zsh"
chsh -s /bin/zsh || (echo "####failed to chsh; exit 1"; exit 1)

($INSTALL_PREZTO && zsh ../../src/my/install_prezto.sh && echo "####succeed to install prezto") || (echo "####failed to install prezto; exit 1"; exit 1)
($INSTALL_PECO && zsh ../../src/my/install_peco.sh && echo "####succeed to install peco") || (echo "####failed to install peco; exit 1"; exit 1)


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

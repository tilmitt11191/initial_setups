#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

libevent_ver="2.1.11-stable"
ncurses_ver="6.1"
tmux_ver=2.8

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit; pwd)
cd "$SCRIPT_DIR" || exit

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

if [ "${IS_UBUNTU}" ]; then
	## install libevent
	# cd $SCRIPT_DIR
	# wget https://github.com/libevent/libevent/releases/download/release-"${libevent_ver}"/libevent-"${libevent_ver}".tar.gz -O ../tmp/libevent-"${libevent_ver}".tar.gz
	# cd ../tmp/
	# tar -zxvf libevent-"${libevent_ver}".tar.gz
	# cd libevent-"${libevent_ver}"
	# ./configure --prefix=$HOME/local
	# make
	# make install

	## install ncurses
	# cd $SCRIPT_DIR
	# wget wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-"${ncurses_ver}".tar.gz -O ../tmp/ncurses-"${ncurses_ver}".tar.gz
	# cd ../tmp/
	# tar -zxvf ncurses-"${ncurses_ver}".tar.gz
	# cd ncurses-"${ncurses_ver}"
	# ./configure --enable-pc-files --prefix=${HOME}/local --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig --with-termlib
	# make
	# make install

	## install tmux
	cd "$SCRIPT_DIR" || exit
	wget https://github.com/tmux/tmux/releases/download/"${tmux_ver}"/tmux-"${tmux_ver}".tar.gz -O ../tmp/tmux-"${tmux_ver}".tar.gz
	cd ../tmp/ || exit
	tar -zxvf tmux-"${tmux_ver}".tar.gz
	cd tmux-"${tmux_ver}" || exit
	PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig ./configure --prefix="${HOME}"/local --enable-static LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include"
	make && make install

elif [ "${IS_CYGWIN}" ]; then
	echo "this is cygwin"
fi

CREATE_DIR="$HOME/.tmux"
[ ! -d "${CREATE_DIR}" ] && echo "create_directory ${CREATE_DIR}" && mkdir -p "${CREATE_DIR}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cd "$INITIALDIR" || exit
exit 0

: <<'#__CO__'
#__CO__

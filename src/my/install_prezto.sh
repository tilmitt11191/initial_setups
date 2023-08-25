#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto" || exit 1
[ $IS_CYGWIN ] && chmod -R +rwx $HOME/.zprezto || exit 1
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" || exit 1
done

cd "${ZDOTDIR:-$HOME}"/.zprezto || exit 1
git pull || exit 1
git submodule update --init --recursive || exit 1

FONTS_DIR=$HOME/tmp/fonts_for_powerline
[ -d $FONTS_DIR ] && rm -rf $FONTS_DIR
git clone https://github.com/powerline/fonts.git --depth=1 $FONTS_DIR || exit 1
cd $FONTS_DIR || exit 1
zsh install.sh || exit 1
# clean-up a bit
rm -rf $FONTS_DIR || exit 1


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

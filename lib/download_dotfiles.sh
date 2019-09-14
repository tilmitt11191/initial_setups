#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR



echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


DATETIME=`date +%Y%m%d%H%M`
[ -e $HOME/.dotfiles ] && mv $HOME/.dotfiles $HOME/.dotfiles.$DATETIME
git clone https://github.com/tilmitt11191/dotfiles $HOME/.dotfiles


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

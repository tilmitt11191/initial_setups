#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ../tmp/installer.sh
pwd
ls
cd ../tmp/
sh ./installer.sh ~/.vim/dein



cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

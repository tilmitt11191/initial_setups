#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR


go get github.com/motemen/ghq
echo -e "[ghq]\n\troot = \$HOME/lib/ghq\nroot = \$HOME/lib/src"


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

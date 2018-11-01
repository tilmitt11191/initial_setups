#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


bash create_shared_dirs_symbolic_link.sh
WIN_HOME=$HOME/c/Users/tilmi
[ -e WIN_HOME ] && ln -s $WIN_HOME/Downloads $HOME/win_downloads


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

wget -O $HOME/lib/rmate https://raw.github.com/aurora/rmate/master/rmate
ln -s $HOME/lib/rmate $HOME/bin/rmate
chmod +x $HOME/bin/rmate

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

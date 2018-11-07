#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


wget https://raw.github.com/aurora/rmate/master/rmate -P $HOME/lib/ --no-check-certificate
ln -s $HOME/lib/rmate $HOME/bin/rmate
chmod +x $HOME/bin/rmate



cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

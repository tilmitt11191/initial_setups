#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

go get github.com/motemen/ghq
echo -e "[ghq]\n\troot = \$HOME/lib/ghq\nroot = \$HOME/lib/src"


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`


DATETIME=`date +%Y%m%d%H%M`
[ -e $HOME/.fonts ] && mv $HOME/.fonts $HOME/.fonts.$DATETIME
git clone https://github.com/tilmitt11191/my_fonts.git $HOME/.fonts
[ "$(uname -a | grep Linux)" ] && fc-cache -fv


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

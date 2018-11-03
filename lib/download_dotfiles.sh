#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


DATETIME=`date +%Y%m%d%H%M`
[ -e $HOME/.dotfiles ] && mv $HOME/.dotfiles $HOME/.dotfiles.$DATETIME
git clone https://github.com/tilmitt11191/dotfiles $HOME/.dotfiles

echo "####apply fonts"
#cp -r $HOME/.dotfiles/fonts/* /user/share/fonts
fc-cache -fv


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

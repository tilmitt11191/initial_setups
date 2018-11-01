#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

[ ! -e $HOME/.config/autostart ] && mkdir -p $HOME/.config/autostart
[ -e $HOME/.config/autostart/gnome-terminal.desktop ] && mv $HOME/.config/autostart/gnome-terminal.desktop $HOME/.config/autostart/gnome-terminal.desktop.org
ln -s $HOME/.dotfiles/etc_ubuntu/config/autostart/gnome-terminal.desktop $HOME/.config/autostart/gnome-terminal.desktop
#gnome-terminal --geometry=1920x1080+0+0


cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

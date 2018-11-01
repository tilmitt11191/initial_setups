#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

if [ $# != 1 ]; then echo "####lack of argument($#)"; exit 1; fi
DATETIME=`date +%Y%m%d%H%M`
[ $1 == "backup" ] && [ -e ~/.dotfiles ] && mv -rf ~/.dotfiles ~/.dotfiles.$DATETIME
[ -e ~/.dotfiles ] && rm -rf ~/.dotfiles
bash ./download_dotfiles.sh

DOTFILES=(vimrc vim tmux.conf fonts)
for file in ${DOTFILES[@]}; do
	[ $1 == "backup" ] && [ -e ~/.$file ] && cp -r ~/.$file ~/."$file".$DATETIME
	[ -e ~/.$file ] && rm -rf ~/.$file
	ln -s ~/.dotfiles/$file ~/.$file
done

##apply fonts
fc-cache -fv

cd $INITIALDIR
exit 0
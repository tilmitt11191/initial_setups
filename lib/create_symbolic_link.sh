#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

if [ $# != 1 ]; then echo "####lack of argument($#)[Y/b/n]"; exit 1; fi


DATETIME=`date +%Y%m%d%H%M`
[ $1 == "backup" ] && [ -e $HOME/.dotfiles ] && mv -rf $HOME/.dotfiles $HOME/.dotfiles.$DATETIME
[ -e $HOME/.dotfiles ] && rm -rf $HOME/.dotfiles
bash ./download_dotfiles.sh

DOTFILES=(zshrc vimrc vim tmux.conf fonts)
for file in ${DOTFILES[@]}; do
	[ $1 == "backup" ] && [ -e $HOME/.$file ] && cp -r $HOME/.$file $HOME/."$file".$DATETIME
	[ -e $HOME/.$file ] && rm -rf $HOME/.$file
	ln -s $HOME/.dotfiles/$file $HOME/.$file
done

[ -e $HOME/bin/pushgitfiles ] && rm -rf $HOME/bin/pushgitfiles
ln -s `pwd`/lib/pushgitfiles $HOME/bin/
sudo chmod +x $HOME/bin/pushgitfiles
export PATH=$HOME/bin:$PATH


cd $INITIALDIR
exit 0
#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

if [ $# != 1 ]; then echo "####lack of argument($#)[Y/b/n]"; exit 1; fi


DATETIME=`date +%Y%m%d%H%M`
if [ -e $HOME/.dotfiles ]; then
	cd $HOME/.dotfiles
	git pull
	cd `dirname $0`
else
	bash ./download_dotfiles.sh
fi

DOTFILES=(zshrc vimrc vim tmux.conf tmux fonts zpreztorc zlogout)
for file in ${DOTFILES[@]}; do
	[ $1 == "backup" ] && [ -e $HOME/.$file ] && cp -r $HOME/.$file $HOME/."$file".$DATETIME
	[ -e $HOME/.$file ] && rm -rf $HOME/.$file
	ln -s $HOME/.dotfiles/$file $HOME/.$file
done

[ -e $HOME/bin/pushgitfiles ] && rm -rf $HOME/bin/pushgitfiles
ln -s `pwd`/pushgitfiles $HOME/bin/
sudo chmod +x $HOME/bin/pushgitfiles
export PATH=$HOME/bin:$PATH


cd $INITIALDIR
exit 0

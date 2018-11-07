#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


DATETIME=`date +%Y%m%d%H%M`
unameOut="$(uname -s)"
IS_CYGWIN=""
IS_LINUX=""
case "${unameOut}" in
	CYGWIN*) echo "##this is Cygwin" && IS_CYGWIN=true;;
	Linux*) echo "##this is Linux" && IS_LINUX=true;;
	*) echo "##this is neither Cygwin nor Linux. exit 1" && exit 1;;
esac

: <<'#__CO__'
case "$1" in
	yes) echo "##mode delete previous dotfiles";;
	backup) echo "##mode backup previous dotfiles as .***.$DATETIME";;
	no) echo "##mode save previous dotfiles as .***.$DATETIME";;
	*) echo "####lack of argument($1)[yes/backup/no]" && exit 2;;
esac

DATETIME=`date +%Y%m%d%H%M`
if [ -e $HOME/.dotfiles ]; then
	CDIR=`pwd`
	cd $HOME/.dotfiles
	git pull
	cd $CDIR
else
	bash ./download_dotfiles.sh
fi

DOTFILES=(zshrc vimrc vim tmux.conf tmux zpreztorc zlogout)
#for file in ${DOTFILES[@]}; do
	[ $1 == "backup" ] && [ -e $HOME/.$file ] && cp -r $HOME/.$file $HOME/."$file".$DATETIME
	[ $1 == "no" ] && [ -e $HOME/.$file ] && cp -r $HOME/.$file $HOME/."$file".$DATETIME
	[ -e $HOME/.$file ] && rm -rf $HOME/.$file
	ln -s $HOME/.dotfiles/$file $HOME/.$file
done
#__CO__

pwd
[ -e $HOME/bin/pushgitfiles ] && rm -rf $HOME/bin/pushgitfiles
ln -s `pwd`/../bin/pushgitfiles $HOME/bin/
sudo chmod +x $HOME/bin/pushgitfiles

if [ ! $IS_CYGWIN ]; then
	[ -e $HOME/bin/st ] && rm -rf $HOME/bin/st
	ln -s `pwd`/../bin/st $HOME/bin/
	sudo chmod +x $HOME/bin/st
fi
export PATH=$HOME/bin:$PATH


cd $INITIALDIR
exit 0

: <<'#__CO__'
if [ $ ]; then
	echo "##"
fi
#__CO__

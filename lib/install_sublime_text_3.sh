#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`


if [ "$(uname -a | grep -e "Ubuntu")" ]; then
	echo "####this is ubuntu"

	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt -y install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt -y update
	sudo apt -y install sublime-text

	if [ -e $HOME/.dotfiles/sublime_text ]; then
		mv $HOME/.config/sublime-text-3/Packages $HOME/.config/sublime-text-3/org.Packages
		ln -s $HOME/.dotfiles/sublime_text/Packages $HOME/.config/sublime-text-3/
		mv $HOME/.config/sublime-text-3/Installed\ Packages $HOME/.config/sublime-text-3/org.Installed\ Packages
		ln -s $HOME/.dotfiles/sublime_text/Installed\ Packages $HOME/.config/sublime-text-3/
	fi

	PACKAGES=(ibus-mozc emacs-mozc)
	for package in ${PACKAGES[@]}; do
		dpkg -l $package | grep -E "^i.+[ \t]+$package" > /dev/null
		if [ $? -ne 0 ];then
			m="$package not installed. sudo apt-get install -y $package."
			echo "$m"
			sudo apt install -y $package
		else
			m="$package already installed."
			echo "$m"
		fi
	done
fi

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

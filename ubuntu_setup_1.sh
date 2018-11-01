#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

echo -n "install prezto? [Y/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) INSTALL_PREZTO=false;;
	* ) INSTALL_PREZTO=true;;
esac

echo "####install zsh and vim"
sudo apt -y update && sudo apt -y dist-upgrade
dpkg -l zsh | grep -E "^i.+[ \t]+zsh" > /dev/null
if [ $? -ne 0 ];then
	m="zsh not installed. sudo apt install -y zsh."
	echo "$m"
	sudo apt install -y zsh
else
	m="zsh already installed."
	echo "$m"
fi


echo "####chsh -s /bin/zsh"
#chsh -s /bin/zsh || (echo "####failed to chsh. exit 1" exit 1)
chsh -s /bin/zsh || exit 1

($INSTALL_PREZTO && zsh lib/install_prezto.sh && echo "####succeed to install prezto") || (echo "####failed to install prezto; exit 1"; exit 1)

echo -n "####Reboot to change shell to zsh"
echo -n "####After rebooted, execute ubuntu_setup_2.sh. Press any key or press Ctrl+c to cancel reboot:"
read


sudo reboot
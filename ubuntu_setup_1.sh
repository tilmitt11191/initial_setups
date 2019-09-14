#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR


gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.session idle-delay 0
sudo apt-get update -y
sudo apt-get dist-upgrade -y
env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update
sudo sh -c "sed -i -e 's/^GRUB_TIMEOUT=.\\+$/GRUB_TIMEOUT=3\nGRUB_RECORDFAIL_TIMEOUT=3/' /etc/default/grub"


echo -n "install prezto? [Y/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) INSTALL_PREZTO=false;;
	* ) INSTALL_PREZTO=true;;
esac

echo "####install zsh and vim"
PACKAGES=(zsh vim)
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

echo "####chsh -s /bin/zsh"
#chsh -s /bin/zsh || (echo "####failed to chsh. exit 1" exit 1)
chsh -s /bin/zsh || exit 1

($INSTALL_PREZTO && zsh lib/install_prezto.sh && echo "####succeed to install prezto") || (echo "####failed to install prezto; exit 1"; exit 1)

echo -n "####Reboot to change shell to zsh"
echo -n "####After rebooted, execute ubuntu_setup_2.sh. Press any key to reboot or press Ctrl+c to cancel reboot:"
read


sudo reboot

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

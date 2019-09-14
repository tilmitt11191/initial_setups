#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR


FLAG_COMMON=true
FLAG_UBUNTU=true
FLAG_VM=""
FLAG_PYTHON=true
FLAG_RUBY=""

if [ `hostname` = "ubuntusetuptest" ]; then
	FLAG_UBUNTU=true
	FLAG_VM=true
	FLAG_PYTHON=true
	FLAG_RUBY=true
fi


echo -n "Change ubuntu settings such as power plan and dock icons? [Y/n] default[Y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) CHANGE_UBUNTU_SETTINGS=false;;
	* ) CHANGE_UBUNTU_SETTINGS=true;;
esac

echo -n "Swap caps for ctrl? [Y/n] default[Y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) SWAP_KEY=false;;
	* ) SWAP_KEY=true;;
esac

echo -n "enable hibernate? [Y/n] default[n]:"
read ANSWER
case $ANSWER in
	"Y" | "y" | "yes" | "Yes" | "YES" ) ENABLE_HIBERNATE=true;;
	* ) ENABLE_HIBERNATE=false;;
esac

echo -n "add convenient repositories? [Y/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) ADD_APT_REPOSITORY=false;;
	* ) ADD_APT_REPOSITORY=true;;
esac

echo -n "add japanese packages? [Y/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) ADD_JAPANESE_PACKAGES=false;;
	* ) ADD_JAPANESE_PACKAGES=true;;
esac

echo -n "install apt packages? [Y/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) INSTALL_APT_PACKAGES=false;;
	* ) INSTALL_APT_PACKAGES=true;;
esac

echo -n "before link to dotfiles, delete or backup default files? [Y/b/n] default[y]:"
read ANSWER
case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) DELETE_DEFAULT_DOTFILES="false";;
	"B" | "b" | "backup" | "Backup" | "BACKUP" ) DELETE_DEFAULT_DOTFILES="backup";;
	* ) DELETE_DEFAULT_DOTFILES="true";;
esac

LANG=C xdg-user-dirs-update --force
CREATE_DIR="$HOME/tmp"
[ ! -d $CREATE_DIR ] && echo "create_directory $CREATE_DIR" && mkdir -p $CREATE_DIR

CREATE_DIR="$HOME/lib"
[ ! -d $CREATE_DIR ] && echo "create_directory $CREATE_DIR" && mkdir -p $CREATE_DIR

CREATE_DIR="$HOME/bin"
[ ! -d $CREATE_DIR ] && echo "create_directory $CREATE_DIR" && mkdir -p $CREATE_DIR

($ADD_APT_REPOSITORY && bash -x lib/add_apt_repositories_and_update.sh && echo "####succeed to add repositories") || (echo "####failed to add repositories; exit 1"; exit 1)
($ADD_JAPANESE_PACKAGES && bash -x lib/add_japanese_packages.sh && echo "####succeed to add japanese packages") || (echo "####failed to add japanese packages; exit1" ; exit 1)
($INSTALL_APT_PACKAGES && bash -x lib/install_apt_packages.sh && echo "####succeed to install apt packages") || (echo "####failed to install apt packages; exit 1"; exit 1)
$SWAP_KEY && bash -x lib/keyswap.sh && echo "####succeed to swap caps for ctrl"
$ENABLE_HIBERNATE && bash -x lib/enable_hibernate.sh && echo "####succeed to enable hibernate"
([ $DELETE_DEFAULT_DOTFILES != "false" ] && bash -x lib/create_symbolic_link.sh $DELETE_DEFAULT_DOTFILES && echo "####succeed to create symbolic links to dotfiles") || (echo "####failed to create symbolic links of dotfiles; exit 1"; exit 1)

if [ "${FLAG_PYTHON}" ]; then
	bash -x lib/install_python.sh
fi

if [ "${FLAG_RUBY}" ]; then
	bash -x lib/install_ruby.sh
fi

$CHANGE_UBUNTU_SETTINGS && bash -x lib/change_ubuntu_settings.sh && echo "####Change ubuntu settings such as power plan and dock icons"

#sudo add-apt-repository -y -n ppa:sicklylife/ppa #for japanese
#sudo add-apt-repository -y -n ppa:graphics-drivers/ppa #for NVIDIA Drivers
#wget https://sicklylife.jp/ubuntu/1804/change-topbar-colon-extend_8_all.deb
#sudo apt update && sudo apt dist-upgrade
#kyeborad setting(全角半角)
#terminal size

#ln dotfiles
#ln shared dir

#apt update


cd $INITIALDIR
echo "####`basename $0` finished. please reboot and answer dialog of dirname"
exit 0


: <<'#__CO__'
#__CO__

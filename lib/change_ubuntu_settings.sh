#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR


SWAPPINESSTIME=10
DOCKSIZE=24

CONFFILE="/etc/sysctl.conf"
echo "####set vm.swappiness = 10"
GREP_RESULT=`cat $CONFFILE | grep "vm.swappiness = [0-9]*"`
if [ -n "$GREP_RESULT" ];then
	echo "current conf is $GREP_RESULT"
	sudo sed -i "s/vm.swappiness = [0-9]*/vm.swappiness = $SWAPPINESSTIME/" $CONFFILE
else
	echo "not hit. add"
	echo "vm.swappiness = 10" | sudo tee -a $CONFFILE
fi
echo "after sed"
cat $CONFFILE | grep "vm.swappiness = [0-9]*"


#list-recursively > ~/tmp/gsettingslist
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.power button-sleep 'nothing'
/usr/bin/gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'


echo "####set dock size $DOCKSIZE and delete unnecessary dock icons"
/usr/bin/gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
/usr/bin/gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.DiskUtility.desktop', 'gparted.desktop', 'gnome-control-center.desktop', 'org.gnome.Software.desktop', 'org.gnome.Nautilus.desktop', 'firefox.desktop', 'gnome-system-monitor_gnome-system-monitor.desktop']"

echo "####set gnome-terminal autostart"
gnome-terminal --geometry=94*47+0+0
[ ! -e $HOME/.config/autostart ] && mkdir -p $HOME/.config/autostart
[ -e $HOME/.config/autostart/gnome-terminal.desktop ] && mv $HOME/.config/autostart/gnome-terminal.desktop $HOME/.config/autostart/gnome-terminal.desktop.org
ln -s $HOME/.dotfiles/etc_ubuntu/config/autostart/gnome-terminal.desktop $HOME/.config/autostart/gnome-terminal.desktop



cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__
cd $INITIALDIR
exit 0
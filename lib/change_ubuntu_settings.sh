#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`

BOOTTIMEOUT=5
SWAPPINESSTIME=10
DOCKSIZE=24

CONFFILE="/boot/grub/grub.cfg"
sudo chmod 644 $CONFFILE
#GREP_RESULT=`cat $CONFFILE | grep "if \[ \""`
#GREP_RESULT=`cat $CONFFILE | grep 'if \[ \"\${recordfail}\" = 1 \] ; then'`
#GREP_RESULT=`cat $CONFFILE | grep -P "if \[ \"[\S]{recordfail}\" = 1 ] ; then"`
GREP_RESULT=`cat $CONFFILE | grep "^  set timeout=[0-9]*"`
echo -e "grep result\n$GREP_RESULT"
if [ -n "$GREP_RESULT" ];then
	echo "hit"
	sudo ls -al $CONFFILE
	sudo sed -i "s/set timeout=[0-9]*/set timeout=$BOOTTIMEOUT/g" $CONFFILE
else
	echo "not hit"
fi
sudo chmod 444 $CONFFILE


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


echo "#### lock screen and auto suspend off"
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
gsettings set org.mate.power-manager sleep-computer-ac 0


echo "####set dock size $DOCKSIZE and delete unnecessary dock icons"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings list-recursively > ~/tmp/gsettingslist




#set dock size 24
#delete unuse appp icons
#blank screen off
#auto suspend off
#show hidden file
cd $INITIALDIR
exit 0
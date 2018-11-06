#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


## install dropbox to ubuntu server 18.04
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd
#dropbox autostart

## install atom
#sudo apt -y install gconf2 gconf-service
#sudo apt -y install gconf-editor
#sudo add-apt-repository ppa:webupd8team/atom
#sudo apt -y update
#sudo apt -y -f install atom || sudo apt -y --fix-broken install

#curl -sL https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
#sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
#sudo apt update
#sudo apt -f install atom

#
### install autossh
#sudo apt-get install gcc make
#wget http://www.harding.motd.ca/autossh/autossh-1.4e.tgz -P ~/lib/autossh
#cd ~/lib/autossh
#tar -xf autossh-1.4e.tgz
#cd autossh-1.4e
#./configure
#make
#sudo make install
ln -s $HOME/lib/autossh/autossh-1.4e/autossh $HOME/bin/autossh
chmod +x $HOME/bin/autossh



cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

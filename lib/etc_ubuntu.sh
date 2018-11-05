#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


## install dropbox to ubuntu server 18.04
: <<'#__CO__'
sudo wget -O /usr/local/bin/dropbox "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod +x /usr/local/bin/dropbox
dropbox
echo "[Unit]
Description=Dropbox Service
After=network.target

[Service]
ExecStart=/bin/sh -c '/usr/local/bin/dropbox start'
ExecStop=/bin/sh -c '/usr/local/bin/dropbox stop'
PIDFile=${HOME}/.dropbox/dropbox.pid
User=sk
Group=sk
Type=forking
Restart=on-failure
RestartSec=5
StartLimitInterval=60s
StartLimitBurst=3

[Install]
WantedBy=multi-user.target
" | sudo tee -a > $HOME/tmp/test.txt
sudo systemctl daemon-reload
sudo systemctl enable dropbox
sudo systemctl start dropbox
#__CO__

#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd
dropbox autostart

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

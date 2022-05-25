#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -  || exit 1
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'  || exit 1
sudo apt update || exit 1
sudo apt upgrade -y || exit 1


PACKAGES=(\
	vim \
	zip \
	tmux \
	git \
	postfix \
	unzip \
	net-tools \
	xvfb \
	google-chrome-stable=91.0.4472.164-1 \
	language-pack-ja-base \
	language-pack-ja \
	ibus-kkc \
	gparted \
)
echo "####install PACKAGES [${PACKAGES[*]}]"
for package in "${PACKAGES[@]}"; do
	dpkg -l "$package" | grep -E "^i.+[ \t]+$package" > /dev/null
	if [ $? -ne 0 ];then
		m="$package not installed. sudo apt-get install -y $package."
		echo "$m"
		sudo apt install -y "$package" || exit 1
	else
		m="$package already installed."
		echo "$m"
	fi
done

sudo apt upgrade -y || exit 1


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

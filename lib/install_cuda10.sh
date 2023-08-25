#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####`basename $0` start."
INITIALDIR=`pwd`
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
cd $SCRIPT_DIR

libcudnn_version="7"

echo "remove --purge cudas? is libcudnn_version ${libcudnn_version}[Y/n]"
read ANSWER
case $ANSWER in
"N" | "n" | "no" | "No" | "NO" ) echo "select No. exit 1"; exit 1;;
* )  eval ${command}|| exit 1;;
esac

#sudo apt update -y && sudo apt upgrade -y
#sudo dpkg -l | grep cuda- | awk '{print $2}' | xargs -n1 sudo apt remove -y --purge
#sudo apt remove -y --purge libcudnn7-dev
#sudo apt remove -y --purge libcudnn7]



cd ../tmp/

sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
sudo dpkg -i libcudnn7_7.6.0.64-1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-dev_7.6.0.64-1+cuda10.0_amd64.deb
sudo dpkg -i libcudnn7-doc_7.6.0.64-1+cuda10.0_amd64.deb
sudo apt install cuda cuda-drivers

echo "have to reboot"

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

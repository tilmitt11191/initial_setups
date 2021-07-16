#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


FLAG_ADD_SUDO=""
USERNAME=$1
echo "#### Add ${USERNAME} to group sudo??[Y/n]"
read -r ANSWER
case $ANSWER in
"Y" | "y" | "yes" | "Yes" | "YES" ) echo "select Yes."; FLAG_ADD_SUDO=True;;
* )  echo "select No. If you want to do, execute following command manually: sudo gpsswd -a ${USERNAME} sudo";;
esac


echo "sudo adduser ${USERNAME}"
echo "Enter password"
sudo adduser "${USERNAME}"

if [ $FLAG_ADD_SUDO ]; then
    echo "sudo gpsswd -a ${USERNAME} sudo"
    sudo gpasswd -a "${USERNAME}" sudo
fi


cd "$INITIALDIR" || exit 1
exit 0

: <<'#__CO__'
#__CO__

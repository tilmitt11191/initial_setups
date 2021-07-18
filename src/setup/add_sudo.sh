#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

# refference
# https://qiita.com/koba1t/items/8e512489d4eb9e90e861
# https://qiita.com/inoko/items/09b9a15cb1a5c83fed34

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


whoami=$(whoami)
echo "${whoami} ALL=(ALL) NOPASSWD: /usr/bin/apt,/usr/bin/apt-key,/bin/sh,/usr/bin/tee,/usr/sbin/service,/bin/chmod,/usr/sbin/usermod,/usr/bin/vim,/sbin/reboot,/sbin/poweroff" | sudo tee "/etc/sudoers.d/initial_setup"


cd "$INITIALDIR" || exit 1
exit 0

: <<'#__CO__'
#__CO__

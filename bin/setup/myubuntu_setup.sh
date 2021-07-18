#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


find ../../ -name "*.sh" -print0 | xargs -0 chmod +x
/usr/bin/gsettings set org.gnome.desktop.session idle-delay 0 || exit 1

bash ../../src/setup/add_sudo.sh || exit 1

bash ../../src/setup/install_packages.sh || exit 1

bash ../../src/my/install_myzsh.sh true true || exit 1

bash ../../src/my/install_mydotfiles.sh no no || exit 1

bash ../../src/setup/install_python.sh 3.9 py39 "$HOME/tmp" ||  (echo "####failed to install_python.sh; exit 1"; exit 1)
export PATH="${HOME}/.pyenv/versions/anaconda/envs/py27/bin:$PATH"
export PATH="${HOME}/.pyenv/versions/anaconda/envs/${INSTALL_PYTHON3_NAME}/bin:$PATH"

/usr/bin/gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
/usr/bin/gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'google-chrome.desktop', 'org.gnome.DiskUtility.desktop', 'gnome-control-center.desktop', 'org.gnome.Software.desktop', 'org.gnome.Nautilus.desktop', 'gnome-system-monitor_gnome-system-monitor.desktop']"


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

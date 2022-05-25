#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


sudo apt install -y peco


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

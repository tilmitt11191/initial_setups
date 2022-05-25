#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


DOES_DELETE_RSYNC=True

SRCDIR="../../../initial_setups/*"
DSTDIR="${HOME}/initial_setups/"

rsync_excludes='--exclude="._*" --exclude="__pycache__" --exclude=".git/"'

if [ $DOES_DELETE_RSYNC ]; then
	rsync_delete="--delete"
fi

rsync_options="$rsync_delete $rsync_excludes"

echo "#### rsync dry-run result is "
command="rsync -avn $rsync_options $SRCDIR $DSTDIR"
eval "${command}"|| exit 1

command="rsync -av $rsync_options $SRCDIR $DSTDIR"
if [ ! -d "$DSTDIR" ] ;then
	echo "targetdir[${DSTDIR}] not exist. create DSTDIR?[Y/n]:"
	read -r ANSWER
	case $ANSWER in
	"N" | "n" | "no" | "No" | "NO" ) echo "select No. exit 1"; exit 1;;
	* ) mkdir -p "$DSTDIR" || exit 1;;
	esac
fi

echo "#### rsync command is"
echo "${command}[Y/n]"
read -r ANSWER
case $ANSWER in
"N" | "n" | "no" | "No" | "NO" ) echo "select No. exit 1"; exit 1;;
* )  eval "${command}"|| exit 1;;
esac

find "${DSTDIR}" -name "*.sh" -print0 | xargs -0 chmod +x


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export LANG=C

echo "####$(basename "$0") start."
INITIALDIR=$(pwd)
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1


if [ $# -ne 3 ]; then
	echo "####$(basename "$0") need 3 args."
	echo "1: INSTALL_PYTHON3_VERSION ex.) 3.8"
	echo "2: INSTALL_PYTHON3_NAME ex.) py38"
	echo "3: temporary directory from ${SCRIPT_DIR} ex.) ./tmp"
	exit 1
fi

ANACONDA_VER=3-2021.05
INSTALL_PYTHON_VERSION=2.7
INSTALL_PYTHON_NAME=py27
INSTALL_PYTHON3_VERSION=$1
INSTALL_PYTHON3_NAME=$2

DIR_TMP=$3

sudo apt update || exit 1
sudo apt upgrade -y || exit 1

PACKAGES=(git build-essential libsm6 libxrender1 python"${INSTALL_PYTHON_VERSION}"-dev python"${INSTALL_PYTHON3_VERSION}"-dev)
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

echo "####install pyenv"
if [ ! -d "${HOME}/.pyenv" ];then
	git clone https://github.com/yyuu/pyenv.git "${HOME}/.pyenv" || exit 1
fi

echo "####install anaconda ${ANACONDA_VER}"
[ ! -e "${DIR_TMP}" ] && mkdir -p "${DIR_TMP}"
if [ -e "${DIR_TMP}/Anaconda${ANACONDA_VER}-Linux-x86_64.sh" ]; then
	echo "skip wget"
else
	wget "https://repo.anaconda.com/archive/Anaconda${ANACONDA_VER}-Linux-x86_64.sh" -O "${DIR_TMP}/Anaconda${ANACONDA_VER}-Linux-x86_64.sh" || exit 1
fi
[ -d "${HOME}/.pyenv/versions/anaconda${ANACONDA_VER}" ] && rm -rf "${HOME}/.pyenv/versions/anaconda${ANACONDA_VER}"
bash "${DIR_TMP}/Anaconda${ANACONDA_VER}-Linux-x86_64.sh" -p "${HOME}/.pyenv/versions/anaconda${ANACONDA_VER}" || exit 1


export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
pyenv init - || echo "failed to pyenv init -. exit 1" && exit 1
pyenv rehash || echo "failed to pyenv rehash. exit 1" && exit 1

DATETIME="$(date +%Y%m%d%H%M)"
if [ -f "${PYENV_ROOT}/versions/anaconda" ] || [ -h "${PYENV_ROOT}/versions/anaconda" ]; then
	mv "${PYENV_ROOT}"/versions/anaconda "${PYENV_ROOT}/versions/anaconda.${DATETIME}" || exit 1
fi

ln -s "${PYENV_ROOT}"/versions/anaconda"${ANACONDA_VER}" "${PYENV_ROOT}"/versions/anaconda || exit 1

export PATH="${PYENV_ROOT}"/versions/anaconda/bin/:"${PATH}"
chmod +x "${PYENV_ROOT}"/versions/anaconda/bin/activate
chmod +x "${PYENV_ROOT}"/versions/anaconda/bin/deactivate
alias activate-anaconda="source ${PYENV_ROOT}/versions/anaconda/bin/activate"
alias deactivate-anaconda="source ${PYENV_ROOT}/versions/anaconda/bin/deactivate"


echo "#### create python ${INSTALL_PYTHON_VERSION} as py${INSTALL_PYTHON_VERSION}"
conda create -ym -n  "${INSTALL_PYTHON_NAME}" python="${INSTALL_PYTHON_VERSION}" || exit 1
echo "#### create python ${INSTALL_PYTHON3_VERSION} as py${INSTALL_PYTHON3_VERSION}"
conda create -ym -n  "${INSTALL_PYTHON3_NAME}" python="${INSTALL_PYTHON3_VERSION}" || exit 1
# ln -s "${PYENV_ROOT}"/versions/anaconda/envs/"${INSTALL_PYTHON3_NAME}"/bin/pip "${PYENV_ROOT}"/versions/anaconda/envs/"${INSTALL_PYTHON3_NAME}"/bin/pip3


cd "$INITIALDIR" || exit 1
echo "####$(basename "$0") finished."
exit 0

: <<'#__CO__'
#__CO__

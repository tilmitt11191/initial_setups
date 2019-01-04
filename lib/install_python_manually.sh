#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`

INSTALL_PYTHON_VERSION=3.6.8
INSTALL_DIR=$HOME/lib

get https://www.python.org/ftp/python/3.6.8/Python-3.6.8.tar.xz --no-check-certificate -O $INSTALL_DIR/python3.6.8
cd $INSTALL_DIR
tar xjf Python-"$INSTALL_PYTHON_VERSION".tar.xz
cd Python-"$INSTALL_PYTHON_VERSION"
make
make install

echo "set PATH as \
export PATH=\"$INSTALL_DIR/python/bin:$PATH\"\
export PYTHONPATH=\"$INSTALL_DIR/python/lib/python3.6/site-packages\"\
export LD_LIBRARY_PATH=\"$INSTALL_DIR/python/lib\"\
"

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

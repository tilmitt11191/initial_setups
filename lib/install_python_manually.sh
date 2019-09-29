#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`

INSTALL_PYTHON_VERSION=3.6.9
INSTALL_DIR="${HOME}/local"

wget "https://www.python.org/ftp/python/${INSTALL_PYTHON_VERSION}/Python-${INSTALL_PYTHON_VERSION}.tar.xz" --no-check-certificate -O "$INSTALL_DIR/python${INSTALL_PYTHON_VERSION}.tar.xz"
cd $INSTALL_DIR
tar xjf "python${INSTALL_PYTHON_VERSION}.tar.xz"
cd Python-"${INSTALL_PYTHON_VERSION}"
./configure  --prefix="${INSTALL_DIR}/python-${INSTALL_PYTHON_VERSION}" CPPFLAGS="-I/usr/local/ssl/include" LDFLAGS="-L/usr/local/ssl/lib"
make
make install

echo "set PATH as \
export PATH=\"$INSTALL_DIR/python/bin:$PATH\"\
export PYTHONPATH=\"$INSTALL_DIR/python/lib/python3.7/site-packages\"\
export LD_LIBRARY_PATH=\"$INSTALL_DIR/python/lib\"\
"

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`pwd`
cd `dirname $0`

ln -s ~/.dotfiles/
git clone https://github.com/smzht/cyg-utils $HOME/lib/cyg-utils
ln -s $HOME/lib/cyg-utils/sudo $HOME/bin/
chmod +x $HOME/bin/sudo

ln -s $HOME/.dotfiles/minttyrc $HOME/.minttyrc

cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

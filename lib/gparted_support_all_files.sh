#!/usr/bin/env bash

echo "####`basename $0` start."
INITIALDIR=`sudo pwd`
cd `dirname $0`


sudo apt -y update && sudo apt -y dist-upgrade

echo "####install packages"
PACKAGES=(btrfs-progs btrfs-tools e2fsprogs f2fs-tools hfsutils hfsprogs jfsutils util-linux cryptsetup dmsetup lvm2 nilfs-tools reiser4progs reiserfsprogs libguestfs-reiserfs udftools xfsprogs xfsdump quota
)
#nilfs-utils
#reiserfs-utils

for package in ${PACKAGES[@]}; do
	dpkg -l $package | grep -E "^i.+[ \t]+$package" > /dev/null
	if [ $? -ne 0 ];then
		m="$package not installed. sudo apt install -y $package."
		echo "$m"
		sudo apt install -y $package
	else
		m="$package already installed."
		echo "$m"
	fi
done




cd $INITIALDIR
exit 0

: <<'#__CO__'
#__CO__

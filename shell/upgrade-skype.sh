#!/bin/bash

PKG_NAME="skypeforlinux"
PKG_FILE="${PKG_NAME}-64.deb"

wget -q --show-progress https://go.skype.com/$PKG_FILE -O $PKG_FILE || exit 1
current=$(dpkg-query --showformat='${Version}' --show $PKG_NAME 2>/dev/null)
update=$(dpkg-deb -f $PKG_FILE Version)
if [[ -n "$current" && "$current" = "$update" ]]; then
	echo "Installed version is already latest: $current"
	exit
fi
echo -en "current\t: "
[ -n "$current" ] && echo "$current" || echo "NONE"
echo -e "update\t: $update"
echo -n "Upgrade? [Y/n] "
read ans
[ -z "$ans" ] && ans="y" || ans=$(echo $ans | tr '[A-Z]' '[a-z]')
[ "$ans" = "y" ] || exit 1
pkill skypeforlinux || exit 1
sudo dpkg -i $PKG_FILE || exit 1
rm -f $PKG_FILE

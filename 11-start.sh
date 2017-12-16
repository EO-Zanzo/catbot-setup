#!/bin/bash

#
#	This script starts IPC server, account generator, etc..
#

if [ $EUID == 0 ]; then
	echo "This script must not be run as root"
	exit
fi

/opt/cathook/ipc/bin/server -s >/dev/null &
pushd account-generator
node app >/dev/null &
popd
pushd cathook-ipc-web-panel
sudo node app >/dev/null &
popd

sleep 5;

echo "Account generator password: `cat /tmp/cat-accgen2-password`"
echo "IPC Web Panel password: `cat /tmp/cat-webpanel-password`"
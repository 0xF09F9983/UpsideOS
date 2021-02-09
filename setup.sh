#!/bin/bash

if [ -f "/dev/UpsideOS" ]; then
	mknod "/dev/UpsideOS" b 7 5
	chown $LOGNAME /dev/UpsideOS
	chmod u+rwx /dev/UpsideOS
fi

losetup --offset 1048576 --sizelimit 46934528 /dev/UpsideOS binaries/OS.img
mkdosfs -F 32 /dev/UpsideOS

if [ -f "OS/" ]; then
	mkdir OS/
fi

if ! mountpoint -q "OS"; then
	mount /dev/UpsideOS OS/
fi

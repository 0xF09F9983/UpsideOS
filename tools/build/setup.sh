#!/bin/bash

loopback=$(losetup -f)

if [ ! -f loopback.info ]; then
	touch loopback.info
	echo $loopback > loopback.info

	echo Setting up a loopback device for binaries/OS.img
	sudo losetup --offset 1048576 --sizelimit 46934528 $loopback binaries/OS.img
	sudo mkdosfs -F 32 $loopback 
fi

if ! mountpoint -q "OS"; then
	echo Mounting OS/
	sudo mount $loopback OS/
fi

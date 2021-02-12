#!/bin/bash

loopback=$(losetup -f)
touch loopback.info
echo $loopback > loopback.info
chown upside loopback.info
chgrp upside loopback.info

if [ ! -f binaries/OS.img ]; then
	if [ ! -d binaries ]; then
		mkdir binaries/
		chown upside binaries/
		chgrp upside binaries/
	fi
	dd if=/dev/zero of=binaries/OS.img bs=512 count=93750
	chown upside binaries/OS.img
	chgrp upside binaries/OS.img

	parted binaries/OS.img -s -a minimal mklabel gpt
	parted binaries/OS.img -s -a minimal mkpart EFI FAT16 2048s 93716s
	parted binaries/OS.img -s -a minimal toggle 1 boot
fi

losetup --offset 1048576 --sizelimit 46934528 $loopback binaries/OS.img
mkdosfs -F 32 $loopback 

if [ ! -d "OS/" ]; then
	mkdir OS/
	chown upside OS/
	chgrp upside OS/
fi

if ! mountpoint -q "OS"; then
	mount $loopback OS/
fi

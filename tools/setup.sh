#!/bin/bash

cd bootloader/ && ./setup.sh && cd ../
cd kernel/ && ./setup.sh && cd ../

if [ ! -f binaries/OS.img ]; then
	if [ ! -d binaries ]; then
		echo Creating binaries/
		mkdir binaries/
	fi
	echo Creating binaries/OS.img
	dd if=/dev/zero of=binaries/OS.img bs=512 count=93750

	echo Creating the gpt partition inside binaries/OS.img
	sudo parted binaries/OS.img -s -a minimal mklabel gpt
	sudo parted binaries/OS.img -s -a minimal mkpart EFI FAT16 2048s 93716s
	sudo parted binaries/OS.img -s -a minimal toggle 1 boot
fi

if [ ! -d "OS/" ]; then
	echo Creating OS/
	mkdir OS/
fi



SHELL = /bin/bash

all: OS.img

OS.img: bootloader kernel
	sudo ./setup.sh
	sudo ./build.sh 
	sudo ./unsetup.sh

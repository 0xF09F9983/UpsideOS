SHELL = /bin/bash

all: OS.img

OS.img: setup
	@echo ===== Setting up the build environment
	./tools/build/setup.sh
	@echo
	@echo ===== Making bootloader
	-cd bootloader && $(MAKE) && cd ../
	@echo
	@echo ===== Making kernel
	-cd kernel/ && $(MAKE) && cd ../
	@echo
	@echo ===== Resetting the build environment
	./tools/build/reset.sh
	@echo

setup: 
	@echo ===== Setting up the project
	./tools/setup.sh
	@echo

reset:
	@echo ===== Resetting the project
	./tools/reset.sh
	@echo

run:
	qemu-system-x86_64 -cpu qemu64 -drive if=pflash,format=raw,unit=0,file=ovmf/OVMF_CODE-pure-efi.fd,readonly=on -drive if=pflash,format=raw,unit=1,file=ovmf/OVMF_VARS-pure-efi.fd -drive if=ide,format=raw,file=binaries/OS.img -net none

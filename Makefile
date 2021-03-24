SHELL = /bin/bash

.PHONY: all
all: binaries/OS.img

binaries/OS.img: loopback = $(shell sudo losetup -f)
binaries/OS.img: setup
	@echo ===== Setting up the build environment
ifeq ($(loopback), "")
	@echo Could not get a free loopback device
else
	@echo Selected loopback device : $(loopback)
endif
	sudo losetup --offset 1048576 --sizelimit 46934528 $(loopback) binaries/OS.img
	sudo mkdosfs -F 32 $(loopback)
	sudo mount $(loopback) OS/
	@echo
	@echo
	@echo ===== Making bootloader
	cd bootloader && $(MAKE) && cd ../
	@echo
	@echo
	@echo ===== Making kernel
	cd kernel/ && $(MAKE) && cd ../
	@echo
	@echo
	@echo ===== Resetting the build environment
	sudo umount OS/
	sudo losetup -d $(loopback)
	@echo
	@echo

.PHONY: setup
setup: img = $(shell ls binaries/OS.img)
setup: 
	@echo ===== Setting up the project
	@echo \* Bootloader :
	@cd bootloader && $(MAKE) setup && cd ../
	@echo
	@echo \* Kernel :
	@cd kernel && $(MAKE) setup && cd ../
	@echo
	@echo \* Main :
	-mkdir binaries/
ifneq ($(img), "binaries/OS.img")
	dd if=/dev/zero of=binaries/OS.img bs=512 count=93750
	sudo parted binaries/OS.img -s -a minimal mklabel gpt
	sudo parted binaries/OS.img -s -a minimal mkpart EFI FAT16 2048s 93716s
	sudo parted binaries/OS.img -s -a minimal toggle 1 boot
endif
	-mkdir OS/
	@echo
	@echo

.PHONY: reset
reset:
	@echo ===== Resetting the project
	@echo \* Bootloader :
	@cd bootloader && $(MAKE) reset && cd ../
	@echo
	@echo \* Kernel :
	@cd kernel && $(MAKE) reset && cd ../
	@echo
	@echo \* Main :
	-rm -drf binaries/
	-rm -drf OS/
	@echo
	@echo

.PHONY: run
run:
	qemu-system-x86_64 -cpu qemu64 -drive if=pflash,format=raw,unit=0,file=ovmf/OVMF_CODE-pure-efi.fd,readonly=on -drive if=pflash,format=raw,unit=1,file=ovmf/OVMF_VARS-pure-efi.fd -drive if=ide,format=raw,file=binaries/OS.img -net none

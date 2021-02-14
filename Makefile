SHELL = /bin/bash

all: OS.img

OS.img:
	./setup.sh
	-cd bootloader && $(MAKE)
	./unsetup.sh

run:
	qemu-system-x86_64 -cpu qemu64 -drive if=pflash,format=raw,unit=0,file=ovmf/OVMF_CODE-pure-efi.fd,readonly=on -drive if=pflash,format=raw,unit=1,file=ovmf/OVMF_VARS-pure-efi.fd -drive if=ide,format=raw,file=binaries/OS.img -net none

.SUFFIXES: 

gnuefi := dependencies/gnu-efi

CC = gcc
CFLAGS = -I"/usr/include/efi" -I"/usr/include/efi/x86_64" -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args
LDFLAGS = -shared -Bsymbolic -L$(gnuefi)/x86_64/gnuefi -L$(gnuefi)/x86_64/lib -T$(gnuefi)/gnuefi/elf_x86_64_efi.lds 

bootloader: main.efi

main.efi: boot.so
	objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-x86_64 --subsystem=10 build/boot.so binaries/boot.efi

boot.so: boot.o
	ld $(LDFLAGS) $(gnuefi)/x86_64/gnuefi/crt0-efi-x86_64.o build/boot.o -o build/boot.so -lgnuefi -lefi

boot.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c sources/boot.c -o build/boot.o

clean:
	rm bin/* build/*

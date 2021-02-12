# Suppress the *annoying* implicit rules
.SUFFIXES: 

PROGRAM := bootloader
BIN_DIR := binaries
SRC_DIR := sources
INC_DIRS := $(SRC_DIR) /usr/include/efi /usr/include/efi/x86_64
BUILD_DIR := build

gnuefi := gnu-efi

CC = gcc
CFLAGS = $(addprefix -I ,$(INC_DIRS))  -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args
LDFLAGS = -shared -Bsymbolic -L$(gnuefi)/x86_64/gnuefi -L$(gnuefi)/x86_64/lib -T$(gnuefi)/gnuefi/elf_x86_64_efi.lds 

all: boot.efi startup.nsh

startup.nsh:
	cp $(SRC_DIR)/startup.nsh $(BIN_DIR)

boot.efi: boot.o
	ld $(LDFLAGS) $(gnuefi)/x86_64/gnuefi/crt0-efi-x86_64.o $(addprefix $(BUILD_DIR)/,$^) -o $(BUILD_DIR)/$(PROGRAM).so  -lgnuefi -lefi
	objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-x86_64 --subsystem=10 $(BUILD_DIR)/$(PROGRAM).so $(BIN_DIR)/$(PROGRAM).efi

boot.o:
	$(CC) $(CFLAGS) -c $(SRC_DIR)/boot.c -o $(BUILD_DIR)/$@

clean:
	rm $(BIN_DIR)/* $(BUILD_DIR)/*

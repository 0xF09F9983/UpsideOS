
# Suppress the *annoying* implicit rules
.SUFFIXES: 

PROGRAM := bootloader

BIN_DIR := binaries
SRC_DIR := sources
INC_DIRS := $(SRC_DIR) /usr/include/efi /usr/include/efi/x86_64
BUILD_DIR := build

C_SRCS := $(wildcard $(SRC_DIR)/*.c)
C_HDRS := $(wildcard $(SRC_DIR)/*.c)
C_OBJS := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(C_SRCS))

gnuefi := gnu-efi

CC = gcc
CFLAGS = $(addprefix -I ,$(INC_DIRS))  -fpic -ffreestanding -fno-stack-protector -fno-stack-check -fshort-wchar -mno-red-zone -maccumulate-outgoing-args
LDFLAGS = -shared -Bsymbolic -L$(gnuefi)/x86_64/gnuefi -L$(gnuefi)/x86_64/lib -T$(gnuefi)/gnuefi/elf_x86_64_efi.lds 

all: startup.nsh $(PROGRAM).efi
	sudo cp binaries/* ../OS/

startup.nsh:
	cp $(SRC_DIR)/startup.nsh $(BIN_DIR)

$(PROGRAM).efi: $(C_OBJS)
	ld $(LDFLAGS) $(gnuefi)/x86_64/gnuefi/crt0-efi-x86_64.o $^ -o $(BUILD_DIR)/$(PROGRAM).so  -lgnuefi -lefi
	objcopy -j .text -j .sdata -j .data -j .dynamic -j .dynsym  -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc --target efi-app-x86_64 --subsystem=10 $(BUILD_DIR)/$(PROGRAM).so $(BIN_DIR)/$(PROGRAM).efi

# Compile the C source files
$(C_OBJS): $(C_SRCS) $(C_HDRS)
	@echo Compiling : $(patsubst $(BUILD_DIR)/%.o,$(SRC_DIR)/%.c,$@) 
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $(patsubst $(BUILD_DIR)/%.o,$(SRC_DIR)/%.c,$@) -o $@ 

clean:
	rm $(BIN_DIR)/* $(BUILD_DIR)/*

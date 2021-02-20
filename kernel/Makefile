# Suppress the *annoying* implicit rules
.SUFFIXES: 

PROGRAM = kernel

BIN_DIR = binaries
SRC_DIR = sources
INC_DIRS = $(SRC_DIR)
BUILD_DIR = build

C_SRCS = $(wildcard $(SRC_DIR)/*.c)
C_OBJS = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(C_SRCS))

CC = gcc
CFLAGS = $(addprefix -I ,$(INC_DIRS)) -ffreestanding -fshort-wchar

LDS = kernel.ld
LD = ld
LDFLAGS = -T $(LDS) -static -Bsymbolic -nostdlib

all: $(PROGRAM).elf
	sudo cp $(BIN_DIR)/* ../OS/

$(PROGRAM).elf: $(C_OBJS)
	@echo Linking : $^
	$(LD) $(LDFLAGS) $^ -o $(BIN_DIR)/$(PROGRAM).elf

# Compile the C source files
$(C_OBJS): $(C_SRCS)
	@echo Compiling : $(patsubst $(BUILD_DIR)/%.o,$(SRC_DIR)/%.c,$@) 
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $(patsubst $(BUILD_DIR)/%.o,$(SRC_DIR)/%.c,$@) -o $@ 

clean:
	rm $(BIN_DIR)/* $(BUILD_DIR)/*

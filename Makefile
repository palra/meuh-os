export NASM=nasm
export NFLAGS=-f bin
export CC=gcc
export CFLAGS=-W -Wall -ansi -pedantic
export LDFLAGS=

# Floppy output
FLOPPY=floppy.img

# Sources dir
SRC_DIR=src/

# Bootsect vars
BOOTLDR_DIR=$(SRC_DIR)bootloader/
export BOOTLDR_EXEC=bootloader.x

# Kernel vars
KERNEL_DIR=$(SRC_DIR)kernel/
export KERNEL_EXEC=kernel.x

# Emulation vars
BOCHS=bochs
BOCHS_OPTS=-q 'display_library: sdl'

# Tasks

all: $(FLOPPY)

run: $(FLOPPY)
	$(BOCHS) $(BOCHS_OPTS) 'boot:a' 'floppya: 1_44=$(FLOPPY), status=inserted'

$(FLOPPY): bootloader kernel
	cat $(BOOTLDR_DIR)$(BOOTLDR_EXEC) $(KERNEL_DIR)$(KERNEL_EXEC) /dev/zero | \
		dd of=$(FLOPPY) bs=512 count=2880

bootloader:
	@(cd $(BOOTLDR_DIR) && $(MAKE))

kernel:
	@(cd $(KERNEL_DIR) && $(MAKE))




.PHONY: $(FLOPPY) clean mrproper

clean:
	rm -rf $(FLOPPY)
	@(cd $(BOOTLDR_DIR) && $(MAKE) clean)
	@(cd $(KERNEL_DIR) && $(MAKE) clean)

mrproper: clean
	@(cd $(BOOTLDR_DIR) && $(MAKE) mrproper)
	@(cd $(KERNEL_DIR) && $(MAKE) mrproper)
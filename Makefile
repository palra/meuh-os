BIN_FOLDER=bin
FLOPPY=$(BIN_FOLDER)/floppy
BOOTSECT=$(BIN_FOLDER)/bootsect
NASM=nasm
BOCHS=bochs
BOCHS_OPTS=-q 'display_library: sdl'

floppy: boot
	cat $(BOOTSECT) /dev/zero | dd of=$(FLOPPY) bs=512 count=2880

boot: src/boot.asm
	$(NASM) -f bin -o $(BOOTSECT) $<

run: floppy
	$(BOCHS) $(BOCHS_OPTS) 'boot:a' 'floppya: 1_44=$(FLOPPY), status=inserted' 

bin-folder:
	mkdir -p $(BIN_FOLDER)

clean:
	rm -fr $(BIN_FOLDER)
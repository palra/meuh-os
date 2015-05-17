FLOPPY=floppy
BOOTSECT=bootsect
NASM=nasm
BOCHS=bochs
BOCHS_OPTS=-q 'display_library: sdl'

floppy: boot
	cat $(BOOTSECT) /dev/zero | dd of=$(FLOPPY) bs=512 count=2880

boot: src/boot.asm
	$(NASM) -f bin -o $(BOOTSECT) $^

run: floppy
	$(BOCHS) $(BOCHS_OPTS) 'boot:a' 'floppya: 1_44=$(FLOPPY), status=inserted' 

clean:
	rm -f $(FLOPPY)
	rm -f $(BOOTSECT)
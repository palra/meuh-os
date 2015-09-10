all: $(BOOTLDR_EXEC)

$(BOOTLDR_EXEC): boot.asm
	$(NASM) $(NFLAGS)  -o $@ $^

.PHONY: clean mrproper

clean:
	rm -fr $(BOOTLDR_EXEC)

mrproper: clean
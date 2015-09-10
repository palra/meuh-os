all: $(KERNEL_EXEC)

$(KERNEL_EXEC): kernel.asm
	$(NASM) $(NFLAGS) -o $@ $^

.PHONY: clean mrproper

clean:
	rm -fr $(KERNEL_EXEC)

mrproper: clean
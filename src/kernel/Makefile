SRC_FOLDER=src/
INCLUDE_FOLDER=include/

CFLAGS += -I $(INCLUDE_FOLDER)
OBJS += main.o screen.o 

all: $(KERNEL_EXEC)

$(KERNEL_EXEC): $(OBJS)
	ld $(LDFLAGS) -Ttext 1000 $^ -o $(KERNEL_EXEC)

%.o: $(SRC_FOLDER)%.cpp
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: $(KERNEL_EXEC) clean mrproper

clean:
	rm -fr *.o

mrproper: clean
	rm -fr $(KERNEL_EXEC)
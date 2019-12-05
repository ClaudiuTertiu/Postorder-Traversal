CFLAGS=-m32
AFLAGS=-f elf

build: postorder

postorder: postorder.o includes/ASTUtils.o includes/macro.o
	gcc $^ -o $@ $(CFLAGS)

postorder.o: postorder.asm
	nasm $^ -o $@ $(AFLAGS)

clean:
	rm -rf postorder.o postorder
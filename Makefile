NAME=bs
OS=os.img

.PHONY: all
all: $(NAME).bin $(OS)

$(NAME).o $(NAME).lst: $(NAME).asm
	nasm -f elf32 -g3 -F dwarf $(NAME).asm -l $(NAME).lst -o $(NAME).o

$(NAME).lst: $(NAME).o

$(NAME).elf: $(NAME).o
	ld -Ttext=0x7c00 -melf_i386 $^ -o $@

$(NAME).bin: $(NAME).elf
	objcopy -O binary $^ $@

$(OS): osbase.img $(NAME).bin
	cp osbase.img os.img
	./copy-to-sector.sh $(NAME).bin os.img 1

.PHONY: run
run: $(OS)
	qemu-system-i386 \
	    -drive file=$^,format=raw,index=0,if=floppy \
	    -curses

.PHONY: debug
debug: $(OS)
	qemu-system-i386 \
	    -S -s \
	    -drive file=$^,format=raw,index=0,if=floppy \
	    -curses

.PHONY: gdbdebug
gdbdebug: $(OS)
	gdb -x gdb-real-mode $(NAME).elf

.PHONY: clean
clean:
	rm -f $(OS) $(NAME).lst $(NAME).elf $(NAME).o $(NAME).bin README.md

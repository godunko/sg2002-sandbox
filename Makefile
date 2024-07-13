
all:
	alr build
	eval `alr printenv` && riscv64-elf-objcopy -O binary bin/bl2.elf bin/bl2.bin
	ls -l bin/

clean:
	alr clean
	rm -rf .objs bin config alire

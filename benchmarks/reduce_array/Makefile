
compile = reduce_array

all: ${compile}

reduce_array: reduce_array.c
	riscv64-unknown-elf-gcc -O1 -g -o reduce_array reduce_array.c

assembly: ${compile} 
	riscv64-unknown-elf-objdump -dS reduce_array > assembly

clean:
	rm -f assembly reduce_array

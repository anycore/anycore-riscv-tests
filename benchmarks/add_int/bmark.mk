add_int_c_src = \
	add_int.c \

add_int_riscv_src = \

add_int_run_files = \

add_int_c_objs     = $(patsubst %.c, add_int/%.o, $(add_int_c_src))
add_int_riscv_objs = $(patsubst %.S, add_int/%.o, $(add_int_riscv_src))

add_int_riscv_bin = add_int/add_int.riscv
$(add_int_riscv_bin) : $(add_int_c_objs) $(add_int_riscv_objs)
	$(RISCV_LINK) $(add_int_c_objs) $(add_int_riscv_objs) -o $(add_int_riscv_bin) $(RISCV_LINK_OPTS)

.PHONY: add_int_riscv_install
add_int_riscv_install: $(add_int_riscv_bin)
	mkdir -p add_int/install
	cp -f $(add_int_riscv_bin) $(add_int_run_files) add_int/install

junk += $(add_int_c_objs) $(add_int_riscv_objs) \
        $(add_int_riscv_bin) add_int/install

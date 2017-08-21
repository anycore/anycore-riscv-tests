add_fp_c_src = \
	add_fp.c \

add_fp_riscv_src = \

add_fp_run_files = \

add_fp_c_objs     = $(patsubst %.c, add_fp/%.o, $(add_fp_c_src))
add_fp_riscv_objs = $(patsubst %.S, add_fp/%.o, $(add_fp_riscv_src))

add_fp_riscv_bin = add_fp/add_fp.riscv
$(add_fp_riscv_bin) : $(add_fp_c_objs) $(add_fp_riscv_objs)
	$(RISCV_LINK) $(add_fp_c_objs) $(add_fp_riscv_objs) -o $(add_fp_riscv_bin) $(RISCV_LINK_OPTS)

.PHONY: add_fp_riscv_install
add_fp_riscv_install: $(add_fp_riscv_bin)
	mkdir -p add_fp/install
	cp -f $(add_fp_riscv_bin) $(add_fp_run_files) add_fp/install

junk += $(add_fp_c_objs) $(add_fp_riscv_objs) \
        $(add_fp_riscv_bin) add_fp/install

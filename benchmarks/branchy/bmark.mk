branchy_c_src = \
	branchy.c \

branchy_riscv_src = \

branchy_run_files = \

branchy_c_objs     = $(patsubst %.c, branchy/%.o, $(branchy_c_src))
branchy_riscv_objs = $(patsubst %.S, branchy/%.o, $(branchy_riscv_src))

branchy_riscv_bin = branchy/branchy.riscv
$(branchy_riscv_bin) : $(branchy_c_objs) $(branchy_riscv_objs)
	$(RISCV_LINK) $(branchy_c_objs) $(branchy_riscv_objs) -o $(branchy_riscv_bin) $(RISCV_LINK_OPTS)

.PHONY: branchy_riscv_install
branchy_riscv_install: $(branchy_riscv_bin)
	mkdir -p branchy/install
	cp -f $(branchy_riscv_bin) $(branchy_run_files) branchy/install

junk += $(branchy_c_objs) $(branchy_riscv_objs) \
        $(branchy_riscv_bin) branchy/install

hello_world_c_src = \
	hello_world.c \

hello_world_riscv_src = \

hello_world_run_files = \

hello_world_c_objs     = $(patsubst %.c, hello_world/%.o, $(hello_world_c_src))
hello_world_riscv_objs = $(patsubst %.S, hello_world/%.o, $(hello_world_riscv_src))

hello_world_riscv_bin = hello_world/hello_world.riscv
$(hello_world_riscv_bin) : $(hello_world_c_objs) $(hello_world_riscv_objs)
	$(RISCV_LINK) $(hello_world_c_objs) $(hello_world_riscv_objs) -o $(hello_world_riscv_bin) $(RISCV_LINK_OPTS)

.PHONY: hello_world_riscv_install
hello_world_riscv_install: $(hello_world_riscv_bin)
	mkdir -p hello_world/install
	cp -f $(hello_world_riscv_bin) $(hello_world_run_files) hello_world/install

junk += $(hello_world_c_objs) $(hello_world_riscv_objs) \
        $(hello_world_riscv_bin) hello_world/install

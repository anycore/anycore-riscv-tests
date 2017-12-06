fibonacci_c_src = \
	fibonacci.c \

fibonacci_riscv_src = \

fibonacci_run_files = \

fibonacci_c_objs     = $(patsubst %.c, fibonacci/%.o, $(fibonacci_c_src))
fibonacci_riscv_objs = $(patsubst %.S, fibonacci/%.o, $(fibonacci_riscv_src))

fibonacci_riscv_bin = fibonacci/fibonacci.riscv
$(fibonacci_riscv_bin) : $(fibonacci_c_objs) $(fibonacci_riscv_objs)
	$(RISCV_LINK) $(fibonacci_c_objs) $(fibonacci_riscv_objs) -o $(fibonacci_riscv_bin) $(RISCV_LINK_OPTS)

.PHONY: fibonacci_riscv_install
fibonacci_riscv_install: $(fibonacci_riscv_bin)
	mkdir -p fibonacci/install
	cp -f $(fibonacci_riscv_bin) $(fibonacci_run_files) fibonacci/install

junk += $(fibonacci_c_objs) $(fibonacci_riscv_objs) \
        $(fibonacci_riscv_bin) fibonacci/install

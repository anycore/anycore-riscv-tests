# This file uses source code from the University of Berkeley RISC-V project 
# in original or modified form.
# Please see LICENSE for details.

#=======================================================================
# UCB VLSI FLOW: Makefile for riscv-bmarks
#-----------------------------------------------------------------------
# Yunsup Lee (yunsup@cs.berkeley.edu)
#

default: all

bmarkdir = .

instname = riscv-bmarks
instbasedir = $(RISCV_INSTALL)/install

#--------------------------------------------------------------------
# Sources
#--------------------------------------------------------------------

bmarks = \
	add_int \
	add_fp \
	hello_world \
	reduce_array \
	branchy \
	fibonacci \

bmarks_host = \
	add_int \
	add_fp \
	hello_world \
	reduce_array \
	branchy \
	fibonacci \

#--------------------------------------------------------------------
# Build rules
#--------------------------------------------------------------------

HOST_OPTS = -std=gnu99 -DPREALLOCATE=0 -DHOST_DEBUG=1
HOST_COMP = gcc $(HOST_OPTS)

RISCV_PREFIX=riscv64-unknown-elf-
RISCV_GCC = $(RISCV_PREFIX)gcc
#RISCV_GCC_OPTS = -static -Wa,-march=RVIMAFDXhwacha -std=gnu99 -O2 -ffast-math -msoft-float
RISCV_GCC_OPTS = -static -Wa,-march=RVIMAFDXhwacha -std=gnu99 -O0 -ffp-contract=off
#RISCV_LINK = $(RISCV_GCC) -T $(bmarkdir)/common/test.ld $(incs)
#RISCV_LINK_MT = $(RISCV_GCC) -T $(bmarkdir)/common/test-mt.ld
RISCV_LINK = $(RISCV_GCC) $(incs)
#RISCV_LINK_OPTS = -nostdlib -nostartfiles -ffast-math -lc
#RISCV_LINK_OPTS = -ffast-math -lc -msoft-float
RISCV_LINK_OPTS =  -lc -msoft-float
RISCV_OBJDUMP = $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.data
RISCV_SIM = spike

VPATH += $(addprefix $(bmarkdir)/, $(bmarks))
#VPATH += $(bmarkdir)/common

#incs  += -I$(bmarkdir)/../env -I$(bmarkdir)/common $(addprefix -I$(bmarkdir)/, $(bmarks))
incs  += $(addprefix -I$(bmarkdir)/, $(bmarks))
objs  :=

include $(patsubst %, $(bmarkdir)/%/bmark.mk, $(bmarks))

#------------------------------------------------------------
# Build and run benchmarks on riscv simulator

bmarks_riscv_install  = $(foreach bmk,$(bmarks),$(bmk)_riscv)
bmarks_riscv_bin  = $(addsuffix .riscv,  $(foreach bmk,$(bmarks),$(bmk)/$(bmk)))
bmarks_riscv_dump = $(addsuffix .riscv.dump, $(foreach bmk,$(bmarks),$(bmk)/$(bmk)))
bmarks_riscv_hex  = $(addsuffix .riscv.hex, $(foreach bmk,$(bmarks),$(bmk)/$(bmk)))
bmarks_riscv_out  = $(addsuffix .riscv.out,  $(foreach bmk,$(bmarks),$(bmk)/$(bmk)))

#bmarks_defs   = -DPREALLOCATE=1 -DHOST_DEBUG=0
#bmarks_cycles = 80000

$(bmarks_riscv_hex): %.hex: %
	elf2hex 16 32768 $< > $@

.PHONY: $(bmarks_riscv_install)
$(bmarks_riscv_install): %: %_install;

$(bmarks_riscv_dump): %.riscv.dump: %.riscv
	$(RISCV_OBJDUMP) $< > $@

$(bmarks_riscv_out): %.riscv.out: %.riscv
	$(RISCV_SIM) $< > $@

%.o: %.c
	$(RISCV_GCC) $(RISCV_GCC_OPTS) $(bmarks_defs) \
	             -c $(incs) $< -o $@

%.o: %.S
	$(RISCV_GCC) $(RISCV_GCC_OPTS) $(bmarks_defs) -D__ASSEMBLY__=1 \
	             -c $(incs) $< -o $@

#riscv: $(bmarks_riscv_dump) $(bmarks_riscv_hex)
riscv: $(bmarks_riscv_dump) $(bmarks_riscv_install) 
run-riscv: $(bmarks_riscv_out)
	echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(bmarks_riscv_out); echo;

junk += $(bmarks_riscv_bin) $(bmarks_riscv_dump) $(bmarks_riscv_hex) $(bmarks_riscv_out)

#------------------------------------------------------------
# Build and run benchmarks on host machine

bmarks_host_bin = $(addsuffix .host, $(foreach bmk,$(bmarks_HOST),$(bmk)/$(bmk)))
bmarks_host_out = $(addsuffix .host.out, $(foreach bmk,$(bmarks_HOST),$(bmk)/$(bmk)))

$(bmarks_host_out): %.host.out: %.host
	./$< > $@

host: $(bmarks_host_bin)
run-host: $(bmarks_host_out)
	echo; perl -ne 'print "  [$$1] $$ARGV \t$$2\n" if /\*{3}(.{8})\*{3}(.*)/' \
	       $(bmarks_host_out); echo;

junk += $(bmarks_host_bin) $(bmarks_host_out)

#------------------------------------------------------------
# Default

all: riscv 

install: install-bin

#------------------------------------------------------------
# Install

date_suffix = $(shell date +%Y-%m-%d_%H-%M)
install_dir = $(instbasedir)/$(instname)-$(date_suffix)
latest_install = $(shell ls -1 -d $(instbasedir)/$(instname)* | tail -n 1)

install-bin:
	mkdir $(install_dir)
	cp -r $(bmarks_riscv_bin) $(bmarks_riscv_dump) $(install_dir)

install-link: install-bin
	rm -rf $(instbasedir)/$(instname)
	ln -s $(latest_install) $(instbasedir)/$(instname)

#------------------------------------------------------------
# Clean up

clean:
	rm -rf $(objs) $(junk)

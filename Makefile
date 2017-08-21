## Important paths
#This is where all tests are run
SCRATCH_SPACE 		= $(abspath ../scratch)

#Path to the SPEC benchmark directory (location of compiled binaries, ref_inputs etc.)
SPEC_SRC_DIR 			= /local/home/rbasuro/spec2006

#This is the path where RISC-V tools are installed
RISCV_INSTALL_DIR	= $(abspath ../install)

## Testcases are a combination of benchmark name and configuration 
## to be used for the run. Any combination can be specified in the
## following way: BENCHMARK_NAME+CONFIGURATION

## Testcases for RTL simulations
all_rtl_tests =	\
				reduce_array+Config1	\
				add_int+Config1	\
				hello_world+Config1	\

## Testcases for gate-level simulations
all_gate_tests =	\
				hello_world+Config1	\
				add_int+Config1	\
				reduce_array+Config1	\

all_spec_tests =	\
				400.perlbench+Config1	\

## Additional testcases can be specified in a separate file and included here.
include tests.mk

all_spec_bmarks =	\
				410.bwaves \
				433.milc \
				437.leslie3d \
				444.namd \
				447.dealII \
				453.povray \
				454.calculix \
				470.lbm \
				400.perlbench	\
				401.bzip2	\
				429.mcf	\
				445.gobmk	\
				458.sjeng	\
				462.libquantum \
				464.h264ref	\
				471.omnetpp	\
				473.astar	\
				483.xalancbmk	\
				##445.hmmer	\
				403.gcc	\
				435.gromacs \
				436.cactusADM \
				450.soplex \
				459.gems \
				482.sphinx3 \
				416.gamess \
				434.zeus \


###### The contents below are advanced and should only be changed if absolutely necessary ####

## Various paths used in testcases
ANYCORE_TEST_DIR 	= $(PWD)
ANYCORE_BASE_DIR 	= $(realpath $(ANYCORE_TEST_DIR)/..)
VERILOG_SRC_DIR	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-src
SYNTH_BASE_DIR 	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-synth

## Following are the run directories for the various testcases
BMARK_SRC_DIR 		= $(ANYCORE_TEST_DIR)/benchmarks
BMARK_BUILD_DIR 	= $(SCRATCH_SPACE)/anycore_bmark_build
RTL_TEST_DIR 			= $(SCRATCH_SPACE)/anycore_rtl_test
GATE_TEST_DIR 		= $(SCRATCH_SPACE)/anycore_gate_test
SPEC_CHKPT_DIR 		= $(SCRATCH_SPACE)/anycore_spec_chkpts
SPEC_SMPT_DIR 		= $(SCRATCH_SPACE)/riscv_spec_smpts


rtl_tests 	= $(addprefix rtl+,$(patsubst \,,$(all_rtl_tests)))
gate_tests 	= $(addprefix gate+,$(patsubst \,,$(all_gate_tests)))
spec_tests 	= $(patsubst \,,$(all_spec_tests))
spec_chkpts = $(addprefix chkpt.,$(patsubst \,,$(all_spec_bmarks)))
spec_smpts 	= $(addprefix smpt.,$(patsubst \,,$(all_spec_bmarks)))

.PHONY: all rtl spec $(rtl_tests) $(spec_tests)
all:	$(rtl_tests)
rtl:	$(rtl_tests)
gate:	$(gate_tests)
spec:	$(spec_tests)
spec_chkpt: ${spec_chkpts}
spec_smpt: ${spec_smpts}

.ONESHELL:


define rtl_test_rule
$(1):
	mkdir -p $(BMARK_BUILD_DIR)
	ln -sf $(BMARK_SRC_DIR)/Makefile $(BMARK_BUILD_DIR)/
	cd $(BMARK_BUILD_DIR);	$(ANYCORE_TEST_DIR)/scripts/lndir $(BMARK_SRC_DIR)/$(2);	cd $(ANYCORE_TEST_DIR)
	echo "BMARK_SRC_DIR = $(BMARK_SRC_DIR)/$(2)"
	echo "BMARK_BUILD_DIR = $(BMARK_BUILD_DIR)/$(2)"
	make -C $(BMARK_BUILD_DIR) bmarks=$(2)
	mkdir -p $(RTL_TEST_DIR)/$(subst +,/,$(1))
	cd $(RTL_TEST_DIR)/$(subst +,/,$(1));	\
	echo "RTL_TEST_DIR = $(shell pwd)";	\
	cp -f $(BMARK_SRC_DIR)/$(2)/job .;	\
	ln -sf $(BMARK_BUILD_DIR)/$(2)/install/* .;	\
	cp -f $(ANYCORE_TEST_DIR)/rtl.mk makefile;	\
	sed -i 's/CONFIG_PLACE_HOLDER/$(3)/g' makefile;	\
	sed -i 's:RISCV_INSTALL_DIR_PLACE_HOLDER:$(RISCV_INSTALL_DIR):g' makefile;	\
	sed -i 's:VERILOG_SRC_DIR_PLACE_HOLDER:$(VERILOG_SRC_DIR):g' makefile;	\
	csh -c 'add cadence2015; make -f makefile run_nc';	\
	cd $(ANYCORE_TEST_DIR)
endef

# Call the macro rtl_test_rule(testcase,benchmark,configuration,test_directory)  - No spaces between arguments
$(foreach testcase,$(rtl_tests),$(eval $(call rtl_test_rule,$(testcase),$(word 2,$(subst	+, ,$(testcase))),$(word 3,$(subst +, ,$(testcase))))))

define gate_test_rule
$(1):
	mkdir -p $(BMARK_BUILD_DIR)
	ln -sf $(BMARK_SRC_DIR)/Makefile $(BMARK_BUILD_DIR)/
	cd $(BMARK_BUILD_DIR);	$(ANYCORE_TEST_DIR)/scripts/lndir $(BMARK_SRC_DIR)/$(2);	cd $(ANYCORE_TEST_DIR)
	echo "BMARK_SRC_DIR = $(BMARK_SRC_DIR)/$(2)"
	echo "BMARK_BUILD_DIR = $(BMARK_BUILD_DIR)/$(2)"
	make -C $(BMARK_BUILD_DIR) bmarks=$(2)
	mkdir -p $(GATE_TEST_DIR)/$(subst +,/,$(1))
	cd $(GATE_TEST_DIR)/$(subst +,/,$(1));	\
	echo "GATE_TEST_DIR = $(shell pwd)";	\
	cp -f $(BMARK_SRC_DIR)/$(2)/job .;	\
	ln -sf $(BMARK_BUILD_DIR)/$(2)/install/* .;	\
	cp -f $(ANYCORE_TEST_DIR)/gate.mk makefile;	\
	sed -i 's/CONFIG_PLACE_HOLDER/$(3)/g' makefile;	\
	sed -i 's:SYNTH_BASE_DIR_PLACE_HOLDER:$(SYNTH_BASE_DIR):g' makefile;	\
	sed -i 's:RISCV_INSTALL_DIR_PLACE_HOLDER:$(RISCV_INSTALL_DIR):g' makefile;	\
	sed -i 's:VERILOG_SRC_DIR_PLACE_HOLDER:$(VERILOG_SRC_DIR):g' makefile;	\
	csh -c 'add cadence2015; make -f makefile run_nc';	\
	cd $(ANYCORE_TEST_DIR)
endef

# Call the macro rtl_test_rule(testcase,benchmark,configuration,test_directory)  - No spaces between arguments
$(foreach testcase,$(gate_tests),$(eval $(call gate_test_rule,$(testcase),$(word 2,$(subst	+, ,$(testcase))),$(word 3,$(subst +, ,$(testcase))))))


define spec_test_rule
$(1):
	echo "BMARK_BIN_DIR = $(SPEC_SRC_DIR)/bin/$(2)"
	mkdir -p $(MICRO_TEST_DIR)/$(4); \
	cp -f $(ANYCORE_TEST_DIR)/micros.mk $(MICRO_TEST_DIR)/$(4)/Makefile; \
	sed -i 's/CONFIG_PLACE_HOLDER/$(3)/g' $(MICRO_TEST_DIR)/$(4)/Makefile; \
	cp -rf $(SPEC_SRC_DIR)/bin/$(2)/* $(MICRO_TEST_DIR)/$(4)/; \
	cp -rf $(SPEC_SRC_DIR)/ref_inputs/$(2)/* $(MICRO_TEST_DIR)/$(4)/; \
	make -C $(MICRO_TEST_DIR)/$(4) -f Makefile bmarks=$(2) CHKPT_DIR=$(SPEC_CHKPT_DIR)/$(2) INPUT_DIR=$(SPEC_SRC_DIR)/ref_inputs/$(2)
endef

# Call the macro spec_test_rule(testcase,benchmark,configuration,test_directory)  - No spaces between arguments
$(foreach testcase,$(spec_tests),$(eval $(call 	spec_test_rule,$(testcase),$(firstword $(subst	+, ,$(testcase))),$(word 2,$(subst +, ,$(testcase))),$(subst +,/,$(testcase)))))


define spec_chkpt_rule
$(1):
	echo "BMARK_BIN_DIR = $(SPEC_SRC_DIR)/bin/$(2)"
	mkdir -p $(SPEC_CHKPT_DIR)/$(2); \
	cp -f $(ANYCORE_TEST_DIR)/chkpt.mk $(SPEC_CHKPT_DIR)/$(2)/Makefile; \
	sed -i 's/CONFIG_PLACE_HOLDER/Config1/g' $(SPEC_CHKPT_DIR)/$(2)/Makefile; \
	cp -rf $(SPEC_SRC_DIR)/bin/$(2)/* $(SPEC_CHKPT_DIR)/$(2)/; \
	cp -rf $(SPEC_SRC_DIR)/ref_inputs/$(2)/* $(SPEC_CHKPT_DIR)/$(2)/; \
	make -C $(SPEC_CHKPT_DIR)/$(2) -f Makefile bmarks=$(2) INPUT_DIR=$(SPEC_SRC_DIR)/ref_inputs/$(2) chkpt
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark) - No spaces between arguments
$(foreach testcase,$(spec_chkpts),$(eval $(call spec_chkpt_rule,$(testcase),$(subst chkpt.,,$(testcase)))))


define spec_smpt_rule
$(1):
	echo "BMARK_BIN_DIR = $(SPEC_SRC_DIR)/bin/$(2)"
	mkdir -p $(SPEC_SMPT_DIR)/$(2); \
	cp -f $(ANYCORE_TEST_DIR)/chkpt.mk $(SPEC_SMPT_DIR)/$(2)/Makefile; \
	sed -i 's/CONFIG_PLACE_HOLDER/Config1/g' $(SPEC_SMPT_DIR)/$(2)/Makefile; \
	cp -rf $(SPEC_SRC_DIR)/bin/$(2)/* $(SPEC_SMPT_DIR)/$(2)/;	\
	cp -rf $(SPEC_SRC_DIR)/ref_inputs/$(2)/* $(SPEC_SMPT_DIR)/$(2)/ 2>/dev/null | :;	\
	make -C $(SPEC_SMPT_DIR)/$(2) -f Makefile bmarks=$(2) INPUT_DIR=$(SPEC_SRC_DIR)/ref_inputs/$(2) smpt
	make -C $(SPEC_SMPT_DIR)/$(2) -f Makefile simpoints
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark) - No spaces between arguments
$(foreach testcase,$(spec_smpts),$(eval $(call spec_smpt_rule,$(testcase),$(subst smpt.,,$(testcase)))))


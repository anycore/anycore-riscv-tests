## Important paths
# This is where all tests are run
#SCRATCH_SPACE 		= $(abspath ../scratch)
SCRATCH_SPACE 		= /local/home/rbasuro/riscv-new-scratch

# This is the path where RISC-V tools are installed
RISCV_INSTALL_DIR	= $(abspath ../install)

SIMPOINT_TOOL_DIR	= $(abspath ../../SimPoint.3.2)

###### The contents below are advanced and should only be changed if absolutely necessary ####

## Various paths used in testcases
ANYCORE_TEST_DIR 	= $(PWD)
ANYCORE_BASE_DIR 	= $(realpath $(ANYCORE_TEST_DIR)/..)
VERILOG_SRC_DIR	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-src
SYNTH_BASE_DIR 	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-synth

## Following are the run directories for the various testcases
MICRO_SRC_DIR 		= $(ANYCORE_TEST_DIR)/benchmarks
RTL_TEST_DIR 			= $(SCRATCH_SPACE)/anycore_rtl_test
GATE_TEST_DIR 		= $(SCRATCH_SPACE)/anycore_gate_test
SPIKE_TEST_DIR  	= $(SCRATCH_SPACE)/spike_test
BMARK_CHKPT_DIR 	= $(SCRATCH_SPACE)/riscv_chkpts
BMARK_SMPT_DIR 		= $(SCRATCH_SPACE)/riscv_smpts
SIMPOINT_INTERVAL = 100000000

# Benchmarks and testcases are specified in a separate file and included here.
# This file contains SPEC benchmarks and testcases by default. If you want to add
# other tests, you must modify this file.
include bmarks.mk

rtl_tests 	= $(addprefix rtl+,$(patsubst \,,$(all_rtl_tests)))
gate_tests 	= $(addprefix gate+,$(patsubst \,,$(all_gate_tests)))
spike_tests = $(addprefix spike+,$(patsubst \,,$(all_spike_tests)))
chkpts 			= $(addprefix chkpt+,$(patsubst \,,$(all_chkpts)))
smpts 			= $(addprefix smpt+,$(patsubst \,,$(all_smpt_bmarks)))

.PHONY: all rtl spec $(rtl_tests) $(spec_tests)
all:	$(rtl_tests)
rtl:	$(rtl_tests)
gate:	$(gate_tests)
spike:	$(spike_tests)
chkpt: 	${chkpts}
smpt: 	${smpts}

.ONESHELL:

#TODO: Store example SPEC jobfiles somewhere
#TODO: Add checkpoints to the job file dynamically
#TODO: Enhance DPI to understand checkpoint file
define rtl_test_rule
$(1):
	@if [ ! -d "$(2)" ]; then \
		echo "Error: The provided benchmark binary directory does not exist. Please check the path."; exit 2; \
	else true; fi
	echo "BMARK_BIN_DIR = $(2)"
	mkdir -p $(RTL_TEST_DIR)/$(3)/$(4)
	cd $(RTL_TEST_DIR)/$(3)/$(4);	\
	echo "RTL_TEST_DIR = $(shell pwd)";	\
	cp -f $(5) .;	\
	cp -rf $(2)/* .;	\
	cp -f $(ANYCORE_TEST_DIR)/rtl.mk makefile;	\
	sed -i 's/CONFIG_PLACE_HOLDER/$(4)/g' makefile;	\
	sed -i 's:RISCV_INSTALL_DIR_PLACE_HOLDER:$(RISCV_INSTALL_DIR):g' makefile;	\
	sed -i 's:VERILOG_SRC_DIR_PLACE_HOLDER:$(VERILOG_SRC_DIR):g' makefile;	\
	csh -c 'add cadence2015; $(MAKE) -f makefile run_nc';	\
	cd $(ANYCORE_TEST_DIR)
endef

# Call the macro rtl_test_rule(testcase,benchmark_location,benchmark,configuration,jobfile)  - No spaces between arguments
$(foreach testcase,$(rtl_tests),$(eval $(call rtl_test_rule,$(testcase),$(word 2,$(subst	+, ,$(testcase))),$(word 3,$(subst +, ,$(testcase))),$(word 4,$(subst +, ,$(testcase))),$(word 5,$(subst +, ,$(testcase))))))

define gate_test_rule
$(1):
	@if [ ! -d "$(2)" ]; then \
		echo "Error: The provided benchmark binary directory does not exist. Please check the path."; exit 2; \
	else true; fi
	echo "BMARK_BIN_DIR = $(2)"
	mkdir -p $(GATE_TEST_DIR)/$(3)/$(4)
	cd $(GATE_TEST_DIR)/$(3)/$(4);	\
	echo "GATE_TEST_DIR = $(shell pwd)";	\
	cp -f $(5) .;	\
	cp -rf $(2)/* .;	\
	cp -f $(ANYCORE_TEST_DIR)/gate.mk makefile;	\
	sed -i 's/CONFIG_PLACE_HOLDER/$(4)/g' makefile;	\
	sed -i 's:SYNTH_BASE_DIR_PLACE_HOLDER:$(SYNTH_BASE_DIR):g' makefile;	\
	sed -i 's:RISCV_INSTALL_DIR_PLACE_HOLDER:$(RISCV_INSTALL_DIR):g' makefile;	\
	sed -i 's:VERILOG_SRC_DIR_PLACE_HOLDER:$(VERILOG_SRC_DIR):g' makefile;	\
	csh -c 'add cadence2015; $(MAKE) -f makefile run_nc';	\
	cd $(ANYCORE_TEST_DIR)
endef

# Call the macro rtl_test_rule(testcase,benchmark_location,benchmark,configuration,jobfile)  - No spaces between arguments
$(foreach testcase,$(gate_tests),$(eval $(call gate_test_rule,$(testcase),$(word 2,$(subst	+, ,$(testcase))),$(word 3,$(subst +, ,$(testcase))),$(word 4,$(subst +, ,$(testcase))),$(word 5,$(subst +, ,$(testcase))))))

micro:
	echo "MICRO_SRC_DIR = $(MICRO_SRC_DIR)"
	+$(MAKE) -C $(MICRO_SRC_DIR)

micro-clean:
	echo "MICRO_SRC_DIR = $(MICRO_SRC_DIR)"
	+$(MAKE) -C $(MICRO_SRC_DIR) clean



####################################################################################################
## This is used to run checkpoints of long benchmarks (e.g. SPEC) on the simulator.
## Please modify the checkpoint names in the spec.mk file to those created using the checkpoint
## generation runs.
####################################################################################################
#get_test_bmark = $(subst spike.,,$(word 2,$(subst +, ,$(1))))
get_test_bmark = $(word 3,$(subst +, ,$(1)))
#get_spike_args = $(strip $(wordlist 4,$(words $(subst +, ,$(1))),$(subst +, ,$(1))))
get_spike_args = $(word 5,$(subst +, ,$(1)))

define spike_test_rule
$(1):
	@if [ ! -d "$(2)" ]; then \
		echo "Error: The provided benchmark binary directory does not exist. Please check the path."; exit 2; \
	else true; fi
	echo "BMARK_BIN_DIR = $(2)"
	#echo "1:$1 2:$2 3:$3 4:$4"
	-mkdir -p $(SPIKE_TEST_DIR)/$(3)/$(4); \
	cp -f $(ANYCORE_TEST_DIR)/spike.mk $(SPIKE_TEST_DIR)/$(3)/$(4)/Makefile; \
	cp -rf $(2)/* $(SPIKE_TEST_DIR)/$(3)/$(4)/ 2>/dev/null | :;	\
	$(MAKE) -C $(SPIKE_TEST_DIR)/$(3)/$(4) -f Makefile bmarks=$(3) RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="$(5)" 
endef

# Call the macro spec_test_rule(testcase,benchmark_location,benchmark,testname,arguments to Spike)  - No spaces between arguments
$(foreach testcase,$(spike_tests),$(eval $(call spike_test_rule,$(testcase),$(word 2,$(subst +, ,$(testcase))),$(call get_test_bmark,$(testcase)),$(word 4,$(subst +, ,$(testcase))),$(call get_spike_args,$(testcase)))))


####################################################################################################
## This is used for generating checkpoints for the calculated simpoints.
## Please modify the skip amounts in the spike.mk file to those dumped by your Simpoint run.
####################################################################################################
#get_chkpt_bmark = $(subst chkpt.,,$(word 2,$(subst +, ,$(1))))
get_chkpt_bmark = $(word 3,$(subst +, ,$(1)))

define chkpt_rule
$(1):
	@if [ ! -d "$(2)" ]; then \
		echo "Error: The provided benchmark binary directory does not exist. Please check the path."; exit 2; \
	else true; fi
	echo "BMARK_BIN_DIR = $(2)"
	#echo "1:$1 2:$2 3:$3 4:$4"
	-mkdir -p $(BMARK_CHKPT_DIR)/$(3); \
	cp -f $(ANYCORE_TEST_DIR)/spike.mk $(BMARK_CHKPT_DIR)/$(3)/Makefile; \
	cp -rf $(2)/* $(BMARK_CHKPT_DIR)/$(3)/ 2>/dev/null | :;	\
	$(MAKE) -C $(BMARK_CHKPT_DIR)/$(3) -f Makefile bmarks=$(3) RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="-c$(shell expr $(4) \* 1000000) -f$(3).$(4)" all
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark_location,benchmark,skip_amt) - No spaces between arguments
$(foreach testcase,$(chkpts),$(eval $(call 	chkpt_rule,$(testcase),$(word 2,$(subst +, ,$(testcase))),$(call get_chkpt_bmark,$(testcase)),$(word 4,$(subst +, ,$(testcase))))))


####################################################################################################
## This is used for collecting basic block vector data for calculating simpoints.
####################################################################################################
#get_smpt_bmark = $(subst smpt.,,$(word 2,$(subst +, ,$(1))))
get_smpt_bmark = $(word 3,$(subst +, ,$(1)))

define smpt_rule
$(1):
	@if [ ! -d "$(2)" ]; then \
		echo "Error: The provided benchmark binary directory does not exist. Please check the path."; exit 2; \
	else true; fi
	echo "BMARK_BIN_DIR = $(2)"
	echo "SIMPOINT_TOOL_DIR = $(SIMPOINT_TOOL_DIR)"
	#echo "1:$1 2:$2 3:$3 4:$4"
	-mkdir -p $(BMARK_SMPT_DIR)/$(3); \
	cp -f $(ANYCORE_TEST_DIR)/spike.mk $(BMARK_SMPT_DIR)/$(3)/Makefile; \
	cp -rf $(2)/* $(BMARK_SMPT_DIR)/$(3)/ 2>/dev/null | :;	\
	$(MAKE) -C $(BMARK_SMPT_DIR)/$(3) -f Makefile RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="-s$(SIMPOINT_INTERVAL)" bmarks=$(3) all
	$(MAKE) -C $(BMARK_SMPT_DIR)/$(3) -f Makefile SIMPOINT_TOOL_DIR=$(SIMPOINT_TOOL_DIR) simpoints
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark_location,benchmark) - No spaces between arguments
$(foreach testcase,$(smpts),$(eval $(call smpt_rule,$(testcase),$(word 2,$(subst +, ,$(testcase))),$(call get_smpt_bmark,$(testcase)))))


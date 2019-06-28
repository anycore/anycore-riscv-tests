###### NOTE: You must edit these paths according to your enviroment #########

## Important paths ####################################
# This is where all tests are run
SCRATCH_SPACE 		= /afs/eos.ncsu.edu/lockers/research/ece/ericro/users/mmkarand/scratch

# This is the path where RISC-V tools are installed
RISCV_INSTALL_DIR	= $(abspath ../install)
RISCV_CHKPTS_DIR	= /home/rbasuro/riscv-new-scratch/riscv-checkpoints

SIMPOINT_TOOL_DIR	= /home/rbasuro/gitrepos/riscv/SimPoint.3.2

# Path to the benchmark build directory (location of compiled binaries, ref_inputs etc.)
# If using Speckle to compile SPEC benchmakrs, provide the path to the Speckle build directory.
SPEC_BIN_DIR 			=  /home/rbasuro/gitrepos/riscv/Speckle/riscv-m64-spec

###### NOTE: You must edit the paths above according to your enviroment #########



###### The contents below are advanced and should only be changed if absolutely necessary ####

## Various paths used in testcases
ANYCORE_TEST_DIR 	= $(PWD)
ANYCORE_BASE_DIR 	= $(realpath $(ANYCORE_TEST_DIR)/..)
VERILOG_SRC_DIR	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-src
SYNTH_BASE_DIR 	 	= $(ANYCORE_BASE_DIR)/anycore-riscv-synth
SCRIPTS_DIR      	= $(abspath scripts)

## Following are the run directories for the various testcases
SPEC_JOBS_DIR			= $(ANYCORE_TEST_DIR)/spec-jobs
MICRO_SRC_DIR 		= $(ANYCORE_TEST_DIR)/benchmarks
RTL_TEST_DIR 			= $(SCRATCH_SPACE)/anycore_rtl_test
GATE_TEST_DIR 		= $(SCRATCH_SPACE)/anycore_gate_test
SPIKE_TEST_DIR  	= $(SCRATCH_SPACE)/spike_test
CHKPT_TEST_DIR 		= $(SCRATCH_SPACE)/riscv_chkpts
SMPT_TEST_DIR 			= $(SCRATCH_SPACE)/riscv_smpts
SIMPOINT_INTERVAL = 100000000

# Benchmarks and testcases are specified in a separate file and included here.
# This file contains SPEC benchmarks and testcases by default. If you want to add
# other tests, you must modify this file.
include bmarks.mk

##CHANGES HERE: NEW VARIABLE
micro_rtl_tests 	= $(addprefix rtl+,$(patsubst \,,$(rtl_micro_tests)))

rtl_tests 	= $(addprefix rtl+,$(patsubst \,,$(all_rtl_tests)))
gate_tests 	= $(addprefix gate+,$(patsubst \,,$(all_gate_tests)))
spike_tests = $(addprefix spike+,$(patsubst \,,$(all_spike_tests)))
chkpts 			= $(addprefix chkpt+,$(patsubst \,,$(all_chkpts)))
smpts 			= $(addprefix smpt+,$(patsubst \,,$(all_smpt_bmarks)))

.PHONY: all rtl spec $(rtl_tests) $(spec_tests)
all:	$(rtl_tests)
rtl:	$(micro_rtl_tests)
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
#	csh -c 'add cadence2015; $(MAKE) -f makefile run_nc';	\
	cd $(ANYCORE_TEST_DIR)

endef

# Call the macro rtl_test_rule(testcase,benchmark_location,benchmark,configuration,jobfile)  - No spaces between arguments
$(foreach testcase,$(micro_rtl_tests),$(eval $(call rtl_test_rule,$(testcase),$(word 2,$(subst	+, ,$(testcase))),$(word 3,$(subst +, ,$(testcase))),$(word 4,$(subst +, ,$(testcase))),$(word 5,$(subst +, ,$(testcase))))))

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

scratch-clean:
	rm -rf ${SCRATCH_SPACE}/anycore_rtl_test

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
	sed -i -e 's:RISCV_INSTALL_DIR_PLACEHOLDER:$(RISCV_INSTALL_DIR):g' $(SPIKE_TEST_DIR)/$(3)/$(4)/Makefile; \
	sed -i -e 's:SIMPOINT_TOOL_DIR_PLACEHOLDER:$(SIMPOINT_TOOL_DIR):g' $(SPIKE_TEST_DIR)/$(3)/$(4)/Makefile; \
	sed -i -e 's:BMARKS_PLACEHOLDER:$(3):g' $(SPIKE_TEST_DIR)/$(3)/$(4)/Makefile; \
	sed -i -e 's:SPIKE_ARGS_PLACEHOLDER:"$(5) -e$(SIMPOINT_INTERVAL)":g' $(SPIKE_TEST_DIR)/$(3)/$(4)/Makefile; \
	cp -rf $(2)/* $(SPIKE_TEST_DIR)/$(3)/$(4)/ 2>/dev/null | :;	\
	$(MAKE) -C $(SPIKE_TEST_DIR)/$(3)/$(4) -f Makefile bmarks=$(3) RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="$(5) -e$(SIMPOINT_INTERVAL)" 
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
	echo "1:$1 2:$2 3:$3 4:$4:$5"
	-mkdir -p $(CHKPT_TEST_DIR)/$(3); \
	cp -f $(ANYCORE_TEST_DIR)/spike.mk $(CHKPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:RISCV_INSTALL_DIR_PLACEHOLDER:$(RISCV_INSTALL_DIR):g' $(CHKPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:SIMPOINT_TOOL_DIR_PLACEHOLDER:$(SIMPOINT_TOOL_DIR):g' $(CHKPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:BMARKS_PLACEHOLDER:$(3):g' $(CHKPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:SPIKE_ARGS_PLACEHOLDER:"-c$(shell expr $(4) \* $(SIMPOINT_INTERVAL)) -f$(3).$(4).$(5)":g' $(CHKPT_TEST_DIR)/$(3)/Makefile; \
	cp -rf $(2)/* $(CHKPT_TEST_DIR)/$(3)/ 2>/dev/null | :;	\
	$(MAKE) -C $(CHKPT_TEST_DIR)/$(3) -f Makefile bmarks=$(3) RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="-c$(shell expr $(4) \* $(SIMPOINT_INTERVAL)) -f$(3).$(4).$(5)" all
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark_location,test_name,skip_amt,weight) - No spaces between arguments
$(foreach testcase,$(chkpts),$(eval $(call 	chkpt_rule,$(testcase),$(word 2,$(subst +, ,$(testcase))),$(call get_chkpt_bmark,$(testcase)),$(word 4,$(subst +, ,$(testcase))),$(word 5,$(subst +, ,$(testcase))))))


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
	-mkdir -p $(SMPT_TEST_DIR)/$(3); \
	cp -f $(ANYCORE_TEST_DIR)/spike.mk $(SMPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:RISCV_INSTALL_DIR_PLACEHOLDER:$(RISCV_INSTALL_DIR):g' $(SMPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:SIMPOINT_TOOL_DIR_PLACEHOLDER:$(SIMPOINT_TOOL_DIR):g' $(SMPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:BMARKS_PLACEHOLDER:$(3):g' $(SMPT_TEST_DIR)/$(3)/Makefile; \
	sed -i -e 's:SPIKE_ARGS_PLACEHOLDER:"-s$(SIMPOINT_INTERVAL)":g' $(SMPT_TEST_DIR)/$(3)/Makefile; \
	cp -rf $(2)/* $(SMPT_TEST_DIR)/$(3)/ 2>/dev/null | :;	\
	$(MAKE) -C $(SMPT_TEST_DIR)/$(3) -f Makefile RISCV_INSTALL_DIR=$(RISCV_INSTALL_DIR) SPIKE_ARGS="-s$(SIMPOINT_INTERVAL)" bmarks=$(3) all
	$(MAKE) -C $(SMPT_TEST_DIR)/$(3) -f Makefile SIMPOINT_TOOL_DIR=$(SIMPOINT_TOOL_DIR) simpoints
endef

# Call the macro spec_checkpoint_rule(testcase,benchmark_location,benchmark) - No spaces between arguments
$(foreach testcase,$(smpts),$(eval $(call smpt_rule,$(testcase),$(word 2,$(subst +, ,$(testcase))),$(call get_smpt_bmark,$(testcase)))))


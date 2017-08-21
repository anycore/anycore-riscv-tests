################################################################################
#                       NORTH CAROLINA STATE UNIVERSITY
#
#                              AnyCore Project
#
# AnyCore Copyright (c) 2007-2011 by Niket K. Choudhary, Salil Wadhavkar,
# and Eric Rotenberg.  All Rights Reserved.
#
# This is a beta-release version.  It must not be redistributed at this time.
#
# Purpose: This is a Makefile for running simulation!!
################################################################################

RISCV_INSTALL_DIR = RISCV_INSTALL_DIR_PLACE_HOLDER
SYNTH_BASE_DIR		= SYNTH_BASE_DIR_PLACE_HOLDER
VERILOG_SRC 			= VERILOG_SRC_DIR_PLACE_HOLDER
GATE_NETLIST_DIR	= $(SYNTH_BASE_DIR)/core-synth/CoreConfig1/synth
GATE_RUN_ID				=	1

# Overwrite CONFIG to change the superset configuration.
CONFIG     = CONFIG_PLACE_HOLDER

# Add additional flags
DEFINES    = -64bit -turbo +define+SIM+VERIFY+GATE_SIM+WAVES+TETRAMAX \
						 -INCDIR $(VERILOG_SRC)/testbenches/


# The Verilog source files
PARAMFILE = $(VERILOG_SRC)/configs/CommonConfig.svh	\
						$(VERILOG_SRC)/configs/$(CONFIG).v

RAMGEN_DIR 	= 	$(realpath $(SYNTH_BASE_DIR)/ramgen/FabMem)

RAMGEN_CELLS=	$(RAMGEN_DIR)/libs/ram/*.v

STD_CELLS = /home/rbasuro/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Verilog/NangateOpenCellLibrary.v \
						/home/rbasuro/NangateOpenCellLibrary_PDKv1_3_v2010_12/Low_Power/Front_End/Verilog/LowPowerOpenCellLibrary.v

INCLUDES 	=	$(PARAMFILE) \
						$(VERILOG_SRC)/ISA/RISCV_ISA.sv \
						$(VERILOG_SRC)/include/structs.svh \
						$(VERILOG_SRC)/regRead/SupRegFile.sv \
						$(VERILOG_SRC)/lsu/MMU.sv \

TESTBENCH	=	$(VERILOG_SRC)/testbenches/l2_icache.sv	\
						$(VERILOG_SRC)/testbenches/l2_dcache.sv	\
						$(VERILOG_SRC)/testbenches/memory_hier.sv	\
						$(VERILOG_SRC)/rams/AL* \
						$(VERILOG_SRC)/retire/ActiveList_tb.sv	\
						$(VERILOG_SRC)/testbenches/simulate.sv

GATE_NETLIST   	= $(GATE_NETLIST_DIR)/netlist/verilog_final_Core_OOO_$(GATE_RUN_ID).v
GATE_SDF				= $(GATE_NETLIST_DIR)/netlist/Core_OOO_typ_$(GATE_RUN_ID).sdf

## Config files for dynamic configuration
TB_CONFIG  = $(VERILOG_SRC)/testbenches/TbConfig1.svh

# Combines all the files
FILES    = 	$(STD_CELLS) $(RAMGEN_CELLS) $(GATE_NETLIST) $(INCLUDES) $(TESTBENCH)

NCSC_RUNARGS = -access rwc -l run.log 

run_nc:
	clear
	mkdir -p results
	rm -rf *.log results/*
	ln -sf $(GATE_SDF) Core_OOO.sdf
	irun -top worklib.simulate:sv -allowredefinition -sv_lib $(RISCV_INSTALL_DIR)/lib/libriscv_dpi.so +ncelabargs+"-timescale 1ns/1ps" +notimingcheck $(DEFINES) $(NCSC_RUNARGS) $(FILES) 2>&1 |tee console.log 

# Runs with the gui
run_nc_g: 
	clear
	mkdir -p results
	rm -rf *.log results/*
	irun -gui -top worklib.simulate:sv -ALLOWREDEFINITION -sv_lib $(RISCV_INSTALL_DIR)/lib/libriscv_dpi.so +ncelabargs+"-timescale 1ns/1ps" +notimingcheck $(DEFINES)  $(NCSC_RUNARGS) $(FILES) 2>&1 |tee console.log

clean:
	rm -rf *.o libvpi.so INCA_libs *.log *.sl work irun.* results/* waves.shm* top outfile .simvision out.* iodine_dpi.so run.log* simvision*

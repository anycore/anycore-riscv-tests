RISCV_INSTALL_DIR = 
SIMPOINT_TOOL_DIR = 
SPIKE_ARGS = 100000000

bmarks = 401.bzip2
#chkpt_skip_amt = 1000  #In millions

#chkpts = $(addprefix chkpt.,${bmarks})
#smpts = $(addprefix smpt.,${bmarks})

.PHONY: all ${bmarks} ${chkpts} check_riscv_install check_simpoint_dir 

all: ${bmarks} check_riscv_install

check_riscv_install:
	@echo "RISCV_INSTALL_DIR = $(RISCV_INSTALL_DIR)"
	@if [ "$(RISCV_INSTALL_DIR)" = "" ]; then \
		echo "Error: Please set RISCV_INSTALL_DIR to the installation path."; exit 2; \
	else true; fi

check_simpoint_dir:
	@echo "SIMPOINT_TOOL_DIR = $(SIMPOINT_TOOL_DIR)"
	@if [ "$(SIMPOINT_TOOL_DIR)" = "" ]; then \
		echo "Error: Please set SIMPOINT_TOOL_DIR to the simpoint tool build path."; exit 2; \
	else true; fi

#TODO: Dump all checkpoints as gzip files instead of plain files

400.perlbench_test:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./perlbench_base.riscv -I. -I./lib test.pl  2>&1 | tee run.log 
401.bzip2_test: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.program 5 2>&1 | tee run.log 
401.gcc_test: 				;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gcc_base.riscv cccp.i -o cccp.s 2>&1 | tee run.log 
429.mcf_test: 				;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./mcf_base.riscv inp.in 2>&1 | tee run.log 
445.gobmk_test:				;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gobmk_base.riscv --quiet --mode gtp < capture.tst 2>&1 | tee run.log 
456.hmmer_test: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./hmmer_base.riscv --fixed 0 --mean 325 --num 45000 --sd 200 --seed 0 bombesin.hmm 2>&1 | tee run.log 
458.sjeng_test: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sjeng_base.riscv test.txt 2>&1 | tee run.log 
462.libquantum_test: 	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./libquantum_base.riscv 33 5 2>&1 | tee run.log 
464.h264ref_test:			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./h264ref_base.riscv -d foreman_test_encoder_baseline.cfg 2>&1 | tee run.log 
471.omnetpp_test: 		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./omnetpp_base.riscv omnetpp.ini 2>&1 | tee run.log 
473.astar_test: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./astar_base.riscv lake.cfg 2>&1 | tee run.log 
483.xalancbmk_test:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./Xalan_base.riscv -v test.xml xalanc.xsl 2>&1 | tee run.log 


410.bwaves_test:			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bwaves_base.riscv 2>&1 | tee run.log 
416.gamess_test:   		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gamess_base.riscv < exam29.config 2>&1 | tee run.log
433.milc_test:  			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./milc_base.riscv < su3imp.in 2>&1 | tee run.log
434.zeusmp_test:    	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./zeusmp_base.riscv 2>&1 | tee run.log
#435.gromacs_test:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gromacs_base.riscv -silent -deffnm gromacs -nice 0 2>&1 | tee run.log
436.cactusADM_test:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./cactusADM_base.riscv benchADM.par 2>&1 | tee run.log
437.leslie3d_test:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./leslie3d_base.riscv < leslie3d.in 2>&1 | tee run.log
#444.namd_test:    		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./namd_base.riscv --input namd.input --iterations 38 --output namd.out 2>&1 | tee run.log
#447.dealII_test:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./dealII_base.riscv 23 2>&1 | tee run.log
#450.soplex_test:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./soplex_base.riscv -s1 -e -m45000 pds-50.mps 2>&1 | tee run.log
453.povray_test:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./povray_base.riscv SPEC-benchmark-test.ini 2>&1 | tee run.log
454.calculix_test:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./calculix_base.riscv -i beampic 2>&1 | tee run.log
459.gems_test:     		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gems_base.riscv 2>&1 | tee run.log
465.tonto_test:    		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./tonto_base.riscv 2>&1 | tee run.log
#470.lbm_test:     		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./lbm_base.riscv 3000 reference.dat 0 0 100_100_130_ldc.of 2>&1 | tee run.log
481.wrf_test:    			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./wrf_base.riscv 2>&1 | tee run.log
482.sphinx3_test: 		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sphinx3_base.riscv ctlfile . args.an4 2>&1 | tee run.log


## Ref Inputs
400.perlbench_ref:	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./perlbench_base.riscv -I. -I./lib test.pl  2>&1 | tee run.log 
401.bzip2_ref: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.program 5 2>&1 | tee run.log 
401.gcc_ref: 				;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gcc_base.riscv expr.i -o expr.s 2>&1 | tee run.log 
429.mcf_ref: 				;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./mcf_base.riscv inp.in 2>&1 | tee run.log 
445.gobmk_ref:			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./go_base.riscv --quiet --mode gtp < score2.tst 2>&1 | tee run.log 
456.hmmer_ref: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./hmmer_base.riscv nph3.hmm swiss41 2>&1 | tee run.log 
458.sjeng_ref: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sjeng_base.riscv ref.txt 2>&1 | tee run.log 
462.libquantum_ref: ;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./libquantum_base.riscv 1397 8 2>&1 | tee run.log 
464.h264ref_ref:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./h264ref_base.riscv -d foreman_ref_encoder_baseline.cfg 2>&1 | tee run.log 
471.omnetpp_ref: 		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./omnetpp_base.riscv omnetpp.ini 2>&1 | tee run.log 
473.astar_ref: 			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./astar_base.riscv BigLakes2048.cfg 2>&1 | tee run.log 
483.xalancbmk_ref:	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./xalan_base.riscv -v t5.xml xalanc.xsl 2>&1 | tee run.log 


410.bwaves_ref:			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bwaves_base.riscv 2>&1 | tee run.log 
416.gamess_ref:   	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gamess_base.riscv < cytosine.2.config 2>&1 | tee run.log
433.milc_ref:  			;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./milc_base.riscv < su3imp.in 2>&1 | tee run.log
434.zeusmp_ref:    	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./zeusmp_base.riscv 2>&1 | tee run.log
435.gromacs_ref:  	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gromacs_base.riscv -silent -deffnm gromacs -nice 0 2>&1 | tee run.log
436.cactusADM_ref:	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./cactus_base.riscv benchADM.par 2>&1 | tee run.log
437.leslie3d_ref:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./leslie3d_base.riscv < leslie3d.in 2>&1 | tee run.log
444.namd_ref:    		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./namd_base.riscv --input namd.input --iterations 38 --output namd.out 2>&1 | tee run.log
447.dealII_ref:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./dealII_base.riscv 23 2>&1 | tee run.log
450.soplex_ref:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./soplex_base.riscv -s1 -e -m45000 pds-50.mps 2>&1 | tee run.log
453.povray_ref:  		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./povray_base.riscv SPEC-benchmark-ref.ini 2>&1 | tee run.log
454.calculix_ref:		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./calculix_base.riscv -i hyperviscoplastic 2>&1 | tee run.log
459.gems_ref:     	;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gems_base.riscv 2>&1 | tee run.log
470.lbm_ref:     		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./lbm_base.riscv 3000 reference.dat 0 0 100_100_130_ldc.of 2>&1 | tee run.log
482.sphinx3_ref: 		;nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sphinx3_base.riscv ctlfile . args.an4 2>&1 | tee run.log

.ONESHELL:
.PHONY: simpoints
#simpoints:	;gunzip bbv_proc_0.bb.gz -c > bbv.bb ; /home/rbasuro/SimPoint.3.2/bin/simpoint -maxK 10 -saveSimpoints simpoints -saveSimpointWeights weights -loadFVFile bbv.bb
simpoints:	check_simpoint_dir
	-gunzip bbv_proc_0.bb.gz -c > bbv.bb ; $(SIMPOINT_TOOL_DIR)/bin/simpoint -maxK 10 -saveSimpoints simpoints -saveSimpointWeights weights -loadFVFile bbv.bb

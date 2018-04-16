RISCV_INSTALL_DIR = RISCV_INSTALL_DIR_PLACEHOLDER
SIMPOINT_TOOL_DIR = SIMPOINT_TOOL_DIR_PLACEHOLDER
SPIKE_ARGS = SPIKE_ARGS_PLACEHOLDER


bmarks = BMARKS_PLACEHOLDER
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


#################################################################################
## SPEC 2006 
#################################################################################

## INT Test Set

400.perlbench_test:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./perlbench_base.riscv -I. -I./lib test.pl  2>&1 | tee run.log 
401.bzip2_program_test:;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.program 5 2>&1 | tee run.log 
401.bzip2_dryer_test: ;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv dryer.jpg 2 2>&1 | tee run.log 
401.gcc_test: 				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gcc_base.riscv cccp.i -o cccp.s 2>&1 | tee run.log 
429.mcf_test: 				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./mcf_base.riscv inp.in 2>&1 | tee run.log 
445.gobmk_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gobmk_base.riscv --quiet --mode gtp < capture.tst 2>&1 | tee run.log 
456.hmmer_test: 			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./hmmer_base.riscv --fixed 0 --mean 325 --num 45000 --sd 200 --seed 0 bombesin.hmm 2>&1 | tee run.log 
458.sjeng_test: 			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sjeng_base.riscv test.txt 2>&1 | tee run.log 
462.libquantum_test: 	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./libquantum_base.riscv 33 5 2>&1 | tee run.log 
464.h264ref_test:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./h264ref_base.riscv -d foreman_test_encoder_baseline.cfg 2>&1 | tee run.log 
471.omnetpp_test: 		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./omnetpp_base.riscv omnetpp.ini 2>&1 | tee run.log 
473.astar_test: 			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./astar_base.riscv lake.cfg 2>&1 | tee run.log 
483.xalancbmk_test:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./Xalan_base.riscv -v test.xml xalanc.xsl 2>&1 | tee run.log 


## FP Test Set

410.bwaves_test:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bwaves_base.riscv 2>&1 | tee run.log 
416.gamess_test:   		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gamess_base.riscv < exam29.config 2>&1 | tee run.log
433.milc_test:  			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./milc_base.riscv < su3imp.in 2>&1 | tee run.log
434.zeusmp_test:    	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./zeusmp_base.riscv 2>&1 | tee run.log
435.gromacs_test:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gromacs_base.riscv -silent -deffnm gromacs --nice 0 2>&1 | tee run.log
436.cactusADM_test:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./cactusADM_base.riscv benchADM.par 2>&1 | tee run.log
437.leslie3d_test:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./leslie3d_base.riscv < leslie3d.in 2>&1 | tee run.log
444.namd_test:    		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./namd_base.riscv --input namd.input --iterations 1 --output namd.out 2>&1 | tee run.log
#447.dealII_test:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./dealII_base.riscv 23 2>&1 | tee run.log
450.soplex_test:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./soplex_base.riscv -s1 -e -m10000 test.mps 2>&1 | tee run.log
453.povray_test:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./povray_base.riscv SPEC-benchmark-test.ini 2>&1 | tee run.log
454.calculix_test:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./calculix_base.riscv -i beampic 2>&1 | tee run.log
459.gems_test:     		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gems_base.riscv 2>&1 | tee run.log
465.tonto_test:    		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./tonto_base.riscv 2>&1 | tee run.log
470.lbm_test:     		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./lbm_base.riscv 20 reference.dat 0 1 100_100_130_cf_a.of 2>&1 | tee run.log
481.wrf_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./wrf_base.riscv 2>&1 | tee run.log
482.sphinx3_test: 		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sphinx3_base.riscv ctlfile . args.an4 2>&1 | tee run.log


## INT Ref Set

400.perlbench_ref:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./perlbench_base.riscv -I. -I./lib test.pl  2>&1 | tee run.log 
401.bzip2_source_ref:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.source 280 2>&1 | tee run.log 
401.bzip2_chicken_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv chicken.jpg 30 2>&1 | tee run.log 
401.bzip2_liberty_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv liberty.jpg 30 2>&1 | tee run.log 
401.bzip2_program_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.program 280 2>&1 | tee run.log 
401.bzip2_text_ref:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv text.html 280 2>&1 | tee run.log 
401.bzip2_combined_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bzip2_base.riscv input.combined 200 2>&1 | tee run.log 
401.gcc_ref: 						;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gcc_base.riscv expr.i -o expr.s 2>&1 | tee run.log 
429.mcf_ref: 						;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./mcf_base.riscv inp.in 2>&1 | tee run.log 
445.gobmk_ref:					;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gobmk_base.riscv --quiet --mode gtp < score2.tst 2>&1 | tee run.log 
456.hmmer_ref: 					;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./hmmer_base.riscv nph3.hmm swiss41 2>&1 | tee run.log 
458.sjeng_ref: 					;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sjeng_base.riscv ref.txt 2>&1 | tee run.log 
462.libquantum_ref: 		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./libquantum_base.riscv 1397 8 2>&1 | tee run.log 
464.h264ref_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./h264ref_base.riscv -d foreman_ref_encoder_baseline.cfg 2>&1 | tee run.log 
471.omnetpp_ref: 				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./omnetpp_base.riscv omnetpp.ini 2>&1 | tee run.log 
473.astar_ref: 					;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./astar_base.riscv BigLakes2048.cfg 2>&1 | tee run.log 
483.xalancbmk_ref:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./Xalan_base.riscv -v t5.xml xalanc.xsl 2>&1 | tee run.log 

## FP Ref Set

410.bwaves_ref:			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./bwaves_base.riscv 2>&1 | tee run.log 
416.gamess_ref:   	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gamess_base.riscv < cytosine.2.config 2>&1 | tee run.log
433.milc_ref:  			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./milc_base.riscv < su3imp.in 2>&1 | tee run.log
434.zeusmp_ref:    	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./zeusmp_base.riscv 2>&1 | tee run.log
435.gromacs_ref:  	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gromacs_base.riscv -silent -deffnm gromacs --nice 0 2>&1 | tee run.log
436.cactusADM_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./cactus_base.riscv benchADM.par 2>&1 | tee run.log
437.leslie3d_ref:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./leslie3d_base.riscv < leslie3d.in 2>&1 | tee run.log
444.namd_ref:    		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./namd_base.riscv --input namd.input --iterations 38 --output namd.out 2>&1 | tee run.log
#447.dealII_ref:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./dealII_base.riscv 23 2>&1 | tee run.log
450.soplex_ref:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./soplex_base.riscv -s1 -e -m45000 pds-50.mps 2>&1 | tee run.log
453.povray_ref:  		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./povray_base.riscv SPEC-benchmark-ref.ini 2>&1 | tee run.log
454.calculix_ref:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./calculix_base.riscv -i hyperviscoplastic 2>&1 | tee run.log
459.gems_ref:     	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./gems_base.riscv 2>&1 | tee run.log
465.tonto_ref:   		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./tonto_base.riscv 2>&1 | tee run.log
470.lbm_ref:     		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./lbm_base.riscv 3000 reference.dat 0 0 100_100_130_ldc.of 2>&1 | tee run.log
481.wrf_ref:    		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./wrf_base.riscv 2>&1 | tee run.log
482.sphinx3_ref: 		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m2048 $(SPIKE_ARGS) pk -c ./sphinx3_base.riscv ctlfile . args.an4 2>&1 | tee run.log


#################################################################################
## SPEC 2017 
#################################################################################

## INT SPEED

600.perlbench_s_rand_test:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c perlbench_s_base.riscv-m64 -I. -I./lib makerand.pl 2>&1 | tee run.log
600.perlbench_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c perlbench_s_base.riscv-m64 -I. -I./lib test.pl 2>&1 | tee run.log
605.mcf_s_test:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m8192 $(SPIKE_ARGS) pk -c mcf_s_base.riscv-m64 inp.in  2>&1 | tee run.log
623.xalancbmk_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xalancbmk_s_base.riscv-m64 -v test.xml xalanc.xsl 2>&1 | tee run.log
625.x264_s_test:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c ldecod_s_base.riscv-m64 -i BuckBunny.264 -o BuckBunny.yuv 2>&1 | tee run.log
641.leela_s_test:    				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c leela_s_base.riscv-m64 test.sgf 2>&1 | tee run.log
648.exchange2_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c exchange2_s_base.riscv-m64 0 

# These run into SYSCALL #96 or other which is not supported by pk
602.gcc_s_test:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sgcc_base.riscv-m64 t1.c -O3 -finline-limit=50000 -o t1.opts-O3_-finline-limit_50000.s >&1 | tee run.log 
620.omnetpp_s_test:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c omnetpp_s_base.riscv-m64 -c General -r 0 2>&1 | tee run.log 
631.deepsjeng_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c deepsjeng_s_base.riscv-m64 test.txt 2>&1 | tee run.log 
657.xz_s_4_0_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1548636 1555348 0 2>&1 | tee run.log
657.xz_s_4_1_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1462248 -1 1 2>&1 | tee run.log
657.xz_s_4_2_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1428548 -1 2 2>&1 | tee run.log
657.xz_s_4_3e_test:   			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1034828 -1 3e 2>&1 | tee run.log
657.xz_s_4_4_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1061968 -1 4 2>&1 | tee run.log
657.xz_s_4_4e_test:   			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1034588 -1 4e 2>&1 | tee run.log
657.xz_s_1_0_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 650156 -1 0 2>&1 | tee run.log
657.xz_s_1_1_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 639996 -1 1  2>&1 | tee run.log
657.xz_s_1_2_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 637616 -1 2 2>&1 | tee run.log
657.xz_s_1_3e_test:   			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 628996 -1 3e 2>&1 | tee run.log
657.xz_s_1_4_test:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 631912 -1 4 2>&1 | tee run.log
657.xz_s_1_4e_test:   			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 1 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 629064 -1 4e 2>&1 | tee run.log

## FP SPEED

# These run into SYSCALL #96 or other which is not supported by pk
603.bwaves_s_1_test:  			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_bwaves_base.riscv-m64 bwaves_1 < bwaves_1.in 2>&1 | tee run.log
603.bwaves_s_2_test:  			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_bwaves_base.riscv-m64 bwaves_2 < bwaves_2.in 2>&1 | tee run.log
607.cactuBSSN_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c cactuBSSN_s_base.riscv-m64 spec_test.par 2>&1 | tee run.log   
619.lbm_s_test:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c lbm_s_base.riscv-m64 20 reference.dat 0 1 200_200_260_ldc.of 2>&1 | tee run.log 
621.wrf_s_test:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c wrf_s_base.riscv-m64 2>&1 | tee run.log 
627.cam4_s_test:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike  -m4096 $(SPIKE_ARGS) pk -c cam4_s_base.riscv-m64 2>&1 | tee run.log 
628.pop2_s_test:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_pop2_base.riscv-m64 2>&1 | tee run.log 
638.imagick_s_test:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c imagick_s_base.riscv-m64 -limit disk 0 test_input.tga -shear 25 -resize 640x480 -negate -alpha Off test_output.tga 2>&1 | tee run.log 
644.nab_s_test:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c nab_s_base.riscv-m64 hkrdenq 1930344093 1000 2>&1 | tee run.log 
649.fotonik3d_s_test:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c fotonik3d_s_base.riscv-m64 2>&1 | tee run.log 
654.roms_s_test:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sroms_base.riscv-m64 < ocean_benchmark0.in 2>&1 | tee run.log 



#### REF Inputs
## INT SPEED

600.perlbench_s_spam_ref:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c perlbench_s_base.riscv-m64 -I./lib checkspam.pl 2500 5 25 11 150 1 1 1 1 2>&1 | tee run.log
600.perlbench_s_diff_ref:		;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c perlbench_s_base.riscv-m64 -I./lib diffmail.pl 4 800 10 17 19 300 2>&1 | tee run.log
600.perlbench_s_split_ref:	;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c perlbench_s_base.riscv-m64 -I./lib splitmail.pl 6400 12 26 16 100 0 2>&1 | tee run.log
605.mcf_s_ref:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m8192 $(SPIKE_ARGS) pk -c mcf_s_base.riscv-m64 inp.in  2>&1 | tee run.log
623.xalancbmk_s_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xalancbmk_s_base.riscv-m64 -v t5.xml xalanc.xsl 2>&1 | tee run.log
625.x264_s_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c ldecod_s_base.riscv-m64 -i BuckBunny.264 -o BuckBunny.yuv 2>&1 | tee run.log
641.leela_s_ref:    				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c leela_s_base.riscv-m64 ref.sgf 2>&1 | tee run.log
648.exchange2_s_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c exchange2_s_base.riscv-m64 6 

# These run into SYSCALL #96 or other which is not supported by pk
602.gcc_s_1_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sgcc_base.riscv-m64 gcc-pp.c -O5 -fipa-pta -o gcc-pp.opts-O5_-fipa-pta.s 2>&1 | tee run.log 
602.gcc_s_2_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sgcc_base.riscv-m64 gcc-pp.c -O5 -finline-limit=1000 -fselective-scheduling -fselective-scheduling2 -o gcc-pp.opts-O5_-finline-limit_1000_-fselective-scheduling_-fselective-scheduling2.s 2>&1 | tee run.log 
602.gcc_s_3_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sgcc_base.riscv-m64 gcc-pp.c -O5 -finline-limit=24000 -fgcse -fgcse-las -fgcse-lm -fgcse-sm -o gcc-pp.opts-O5_-finline-limit_24000_-fgcse_-fgcse-las_-fgcse-lm_-fgcse-sm.s 2>&1 | tee run.log 
620.omnetpp_s_ref:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c omnetpp_s_base.riscv-m64 -c General -r 0 2>&1 | tee run.log 
631.deepsjeng_s_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c deepsjeng_s_base.riscv-m64 ref.txt 2>&1 | tee run.log 
657.xz_s_docs_ref:    			;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cpu2006docs.tar.xz 6643 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1036078272 1111795472 4 2>&1 | tee run.log
657.xz_s_cld_ref:    				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c xz_s_base.riscv-m64 cld.tar.xz 1400 19cf30ae51eddcbefda78dd06014b4b96281456e078ca7c13e1c0c9e6aaea8dff3efb4ad6b0456697718cede6bd5454852652806a657bb56e07d61128434b474 536995164 539938872 8 2>&1 | tee run.log

## FP SPEED

# These run into SYSCALL #96 or other which is not supported by pk
603.bwaves_s_1_ref:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_bwaves_base.riscv-m64 bwaves_1 < bwaves_1.in 2>&1 | tee run.log
603.bwaves_s_2_ref:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_bwaves_base.riscv-m64 bwaves_2 < bwaves_2.in 2>&1 | tee run.log
607.cactuBSSN_s_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c cactuBSSN_s_base.riscv-m64 spec_ref.par 2>&1 | tee run.log   
619.lbm_s_ref:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c lbm_s_base.riscv-m64 2000 reference.dat 0 0 200_200_260_ldc.of 2>&1 | tee run.log 
621.wrf_s_ref:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c wrf_s_base.riscv-m64 2>&1 | tee run.log 
627.cam4_s_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike  -m4096 $(SPIKE_ARGS) pk -c cam4_s_base.riscv-m64 2>&1 | tee run.log 
628.pop2_s_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c speed_pop2_base.riscv-m64 2>&1 | tee run.log 
638.imagick_s_ref:  				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c magick_s_base.riscv-m64 -limit disk 0 refspeed_input.tga -resize 817% -rotate -2.76 -shave 540x375 -alpha remove -auto-level -contrast-stretch 1x1% -colorspace Lab -channel R -equalize +channel -colorspace sRGB -define histogram:unique-colors=false -adaptive-blur 0x5 -despeckle -auto-gamma -adaptive-sharpen 55 -enhance -brightness-contrast 10x10 -resize 30% refspeed_output.tga 2>&1 | tee run.log 
644.nab_s_ref:      				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c nab_s_base.riscv-m64 3j1n 20140317 220 2>&1 | tee run.log 
649.fotonik3d_s_ref:				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c fotonik3d_s_base.riscv-m64 2>&1 | tee run.log 
654.roms_s_ref:     				;-nice -19 $(RISCV_INSTALL_DIR)/bin/spike	-m4096 $(SPIKE_ARGS) pk -c sroms_base.riscv-m64 < ocean_benchmark3.in 2>&1 | tee run.log 




.ONESHELL:
.PHONY: simpoints
simpoints:	check_simpoint_dir
	-gunzip bbv_proc_0.bb.gz -c > bbv.bb ; $(SIMPOINT_TOOL_DIR)/bin/simpoint -maxK 10 -saveSimpoints simpoints -saveSimpointWeights weights -loadFVFile bbv.bb | tee smpt.log; rm -f bbv.bb

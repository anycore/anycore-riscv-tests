########################################################################
## Testcases for RTL simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way \ 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+RTL_CONFIG_NAME+TEST_SUB_DIR+JOB_FILE_PATH+[OPTIONAL_CHECKPOINT_PATH]

## Testcases for microbenchmarks that run from the begining
## CHANGES HERE: 
rtl_micro_tests =	\
				$(MICRO_SRC_DIR)/fibonacci/install+fibonacci+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/fibonacci/install+fibonacci+Config2+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/hello_world/install+hello_world+Config1+$(MICRO_SRC_DIR)/hello_world/job	\
				$(MICRO_SRC_DIR)/hello_world/install+hello_world+Config2+$(MICRO_SRC_DIR)/hello_world/job	\
				$(MICRO_SRC_DIR)/add_int/install+add_int+Config1+$(MICRO_SRC_DIR)/add_int/job	\
				$(MICRO_SRC_DIR)/add_int/install+add_int+Config2+$(MICRO_SRC_DIR)/add_int/job	\
				$(MICRO_SRC_DIR)/add_fp/install+add_fp+Config1+$(MICRO_SRC_DIR)/add_fp/job	\
				$(MICRO_SRC_DIR)/add_fp/install+add_fp+Config2+$(MICRO_SRC_DIR)/add_fp/job	\
				$(MICRO_SRC_DIR)/reduce_array/install+reduce_array+Config1+$(MICRO_SRC_DIR)/reduce_array/job	\
				$(MICRO_SRC_DIR)/reduce_array/install+reduce_array+Config2+$(MICRO_SRC_DIR)/reduce_array/job	\
				$(MICRO_SRC_DIR)/branchy/install+branchy+Config1+$(MICRO_SRC_DIR)/branchy/job	\
				$(MICRO_SRC_DIR)/branchy/install+branchy+Config2+$(MICRO_SRC_DIR)/branchy/job	\
				$(MICRO_SRC_DIR)/astar/install+astar+Config1+$(MICRO_SRC_DIR)/astar/job	\



## Testcases for benchmarks that run from the begining
rtl_bmark_tests = \
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+Config1+$(SPEC_JOBS_DIR)/401.bzip2_test_job

## Testcases for benchmarks that run using checkpoints
rtl_chkpt_tests = \
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+Config1+$(SPEC_JOBS_DIR)/401.bzip2_test_job+-f$(RISCV_CHKPTS_DIR)/401.bzip2_test/401.bzip2_test.3350

all_rtl_tests =	\
				$(rtl_micro_tests) \
				$(rtl_bmark_tests) \
				$(rtl_chkpt_tests) \

########################################################################
## Testcases for gate-level simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way \ 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+RTL_CONFIG_NAME+TEST_SUB_DIR+JOB_FILE_PATH+[OPTIONAL_CHECKPOINT_PATH]

all_gate_tests =	$(all_rtl_tests)

########################################################################
## Testcases for Spike instruction set simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way \ 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+TEST_SUB_DIR+[OPTIONAL_CHECKPOINT_PATH]+[OPTIONAL_OTHER_SPIKE_ARGS]..

spike_micro_tests =	\
				$(MICRO_SRC_DIR)/fibonacci/install+fibonacci \
				$(MICRO_SRC_DIR)/hello_world/install+hello_world \
				$(MICRO_SRC_DIR)/hellow_world/install+add_int \
				$(MICRO_SRC_DIR)/hello_world/install+reduce_array \
				$(MICRO_SRC_DIR)/branchy/install+brancy \

## Testcases for benchmarks that run from the begining
spike_bmark_tests =	\
				$(SPEC_BIN_DIR)/445.gobmk_test+445.gobmk_test+0 \
				$(SPEC_BIN_DIR)/456.hmmer_test+456.hmmer_test+0 \

## Testcases for benchmarks that run using checkpoints
spike_chkpt_tests =	\
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+335+-f$(RISCV_CHKPTS_DIR)/401.bzip2_test/401.bzip2_test.335 \
				$(SPEC_BIN_DIR)/456.hmmer_test+456.hmmer_test+135+-f$(RISCV_CHKPTS_DIR)/456.hmmer_test/456.hmmer_test.135 \

## Testcases defined in a CSV file
spike_csv_tests = $(shell $(SCRIPTS_DIR)/create_testcase.py --csv tests/spike_tests.csv -b $(SPEC_BIN_DIR) |grep -vi error)

all_spike_tests =	\
				$(spike_csv_tests) \
				#$(spike_chkpt_tests) \
				#$(spike_micro_tests) \
				$(spike_bmark_tests) \

########################################################################
## Testcases for generating Checkpoints on benchmarks
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way \ 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+CHECKPOINT_SKIP_AMT

chkpt_spec_test =	\
					$(SPEC_BIN_DIR)/462.libquantum_test+462.libquantum_test+1+0.33 \
					$(SPEC_BIN_DIR)/465.tonto_test+465.tonto_test+67+0.20 \
					$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_4e_test+16+0.18 \

chkpt_spec_ref =	\
					$(SPEC_BIN_DIR)/429.mcf_ref+429.mcf_ref+1658+0.17 \
					$(SPEC_BIN_DIR)/453.povray_ref+453.povray_ref+3971+0.22 \
					$(SPEC_BIN_DIR)/657.xz_s_ref+657.xz_s_cld_ref+0,0.13 \ 

## Testcases defined in a CSV file
chkpt_csv_tests = $(shell $(SCRIPTS_DIR)/create_testcase.py --csv tests/checkpoint_tests.csv -b $(SPEC_BIN_DIR) |grep -vi error)
all_chkpts =	\
				$(SPEC_BIN_DIR)/470.lbm_test+470.lbm_test+142+0.40 \
				$(SPEC_BIN_DIR)/445.gobmk_ref+445.gobmk_ref+1468+0.20 \
				$(SPEC_BIN_DIR)/483.xalancbmk_ref+483.xalancbmk_ref+7228+0.31 \
				#$(SPEC_BIN_DIR)/465.tonto_ref+465.tonto_ref \
				#	$(chkpt_csv_tests)
					#$(chkpt_spec_test) \
					$(chkpt_spec_ref) \

########################################################################
## Testcases for running Simpoints on benchmarks
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way \ 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME

smpt_spec_2k6_test_bmarks =	\
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_program_test \
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_dryer_test \
				$(SPEC_BIN_DIR)/429.mcf_test+429.mcf_test \
				$(SPEC_BIN_DIR)/445.gobmk_test+445.gobmk_test \
				$(SPEC_BIN_DIR)/456.hmmer_test+456.hmmer_test \
				$(SPEC_BIN_DIR)/458.sjeng_test+458.sjeng_test \
				$(SPEC_BIN_DIR)/462.libquantum_test+462.libquantum_test \
				$(SPEC_BIN_DIR)/464.h264ref_test+464.h264ref_test \
				$(SPEC_BIN_DIR)/471.omnetpp_test+471.omnetpp_test \
				$(SPEC_BIN_DIR)/473.astar_test+473.astar_test \
				$(SPEC_BIN_DIR)/483.xalancbmk_test+483.xalancbmk_test \
				$(SPEC_BIN_DIR)/410.bwaves_test+410.bwaves_test \
				$(SPEC_BIN_DIR)/433.milc_test+433.milc_test \
				$(SPEC_BIN_DIR)/437.leslie3d_test+437.leslie3d_test \
				$(SPEC_BIN_DIR)/444.namd_test+444.namd_test \
				$(SPEC_BIN_DIR)/453.povray_test+453.povray_test \
				$(SPEC_BIN_DIR)/454.calculix_test+454.calculix_test \
				$(SPEC_BIN_DIR)/465.tonto_test+465.tonto_test \
				$(SPEC_BIN_DIR)/470.lbm_test+470.lbm_test \
				## The following benchmarks segfault \
				$(SPEC_BIN_DIR)/481.wrf_test+481.wrf_test \
				## The following benchmarks do not simulate correctly \
				$(SPEC_BIN_DIR)/400.perlbench_test+400.perlbench_test \
				$(SPEC_BIN_DIR)/403.gcc_test+403.gcc_test \
				$(SPEC_BIN_DIR)/416.gamess_test+416.gamess_test \
				$(SPEC_BIN_DIR)/434.zeusmp_test+434.zeusmp_test \
				$(SPEC_BIN_DIR)/435.gromacs_test+435.gromacs_test \
				$(SPEC_BIN_DIR)/436.cactusADM_test+436.cactusADM_test \
				$(SPEC_BIN_DIR)/450.soplex_test+450.soplex_test \
				$(SPEC_BIN_DIR)/459.gemsFDTD_test+459.gemsFDTD_test \
				$(SPEC_BIN_DIR)/482.sphinx3_test+482.sphinx3_test \

smpt_spec_2k6_ref_bmarks =	\
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_source_ref \
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_chicken_ref \
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_liberty_ref \
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_program_ref \
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_text_ref \
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_combined_ref \
				$(SPEC_BIN_DIR)/429.mcf_ref+429.mcf_ref \
				$(SPEC_BIN_DIR)/445.gobmk_ref+445.gobmk_ref \
				$(SPEC_BIN_DIR)/458.sjeng_ref+458.sjeng_ref \
				$(SPEC_BIN_DIR)/462.libquantum_ref+462.libquantum_ref \
				$(SPEC_BIN_DIR)/464.h264ref_ref+464.h264ref_ref \
				$(SPEC_BIN_DIR)/471.omnetpp_ref+471.omnetpp_ref \
				$(SPEC_BIN_DIR)/473.astar_ref+473.astar_ref \
				$(SPEC_BIN_DIR)/483.xalancbmk_ref+483.xalancbmk_ref \
				$(SPEC_BIN_DIR)/410.bwaves_ref+410.bwaves_ref \
				$(SPEC_BIN_DIR)/433.milc_ref+433.milc_ref \
				$(SPEC_BIN_DIR)/437.leslie3d_ref+437.leslie3d_ref \
				$(SPEC_BIN_DIR)/444.namd_ref+444.namd_ref \
				$(SPEC_BIN_DIR)/453.povray_ref+453.povray_ref \
				$(SPEC_BIN_DIR)/454.calculix_ref+454.calculix_ref \
				$(SPEC_BIN_DIR)/465.tonto_ref+465.tonto_ref \
				$(SPEC_BIN_DIR)/470.lbm_ref+470.lbm_ref \
				## The following benchmarks segfault \
				$(SPEC_BIN_DIR)/481.wrf_ref+481.wrf_ref \
				## The following benchmarks do not simulate correctly \
				$(SPEC_BIN_DIR)/400.perlbench_ref+400.perlbench_ref \
				$(SPEC_BIN_DIR)/403.gcc_ref+403.gcc_ref \
				$(SPEC_BIN_DIR)/456.hmmer_ref+456.hmmer_ref \
				$(SPEC_BIN_DIR)/416.gamess_ref+416.gamess_ref \
				$(SPEC_BIN_DIR)/434.zeusmp_ref+434.zeusmp_ref \
				$(SPEC_BIN_DIR)/435.gromacs_ref+435.gromacs_ref \
				$(SPEC_BIN_DIR)/436.cactusADM_ref+436.cactusADM_ref \
				$(SPEC_BIN_DIR)/447.dealII_ref+447.dealII_ref \
				$(SPEC_BIN_DIR)/450.soplex_ref+450.soplex_ref \
				$(SPEC_BIN_DIR)/459.gemsFDTD_ref+459.gemsFDTD_ref \
				$(SPEC_BIN_DIR)/482.sphinx3_ref+482.sphinx3_ref \

smpt_spec_2k17_test_bmarks = \
				$(SPEC_BIN_DIR)/638.imagick_s_test+638.imagick_s_test \
				$(SPEC_BIN_DIR)/644.nab_s_test+644.nab_s_test \
				$(SPEC_BIN_DIR)/600.perlbench_s_test+600.perlbench_s_rand_test \
				$(SPEC_BIN_DIR)/623.xalancbmk_s_test+623.xalancbmk_s_test \
				$(SPEC_BIN_DIR)/641.leela_s_test+641.leela_s_test \
				$(SPEC_BIN_DIR)/602.gcc_s_test+602.gcc_s_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_0_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_1_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_2_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_3e_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_4_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_4_4e_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_0_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_1_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_2_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_3e_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_4_test \
				$(SPEC_BIN_DIR)/657.xz_s_test+657.xz_s_1_4e_test \
				#$(SPEC_BIN_DIR)/600.perlbench_s_test+600.perlbench_s_test \
				#$(SPEC_BIN_DIR)/625.x264_s_test+625.x264_s_test \

smpt_spec_2k17_ref_bmarks = \
				$(SPEC_BIN_DIR)/638.imagick_s_ref+638.imagick_s_ref \
				$(SPEC_BIN_DIR)/644.nab_s_ref+644.nab_s_ref \
				$(SPEC_BIN_DIR)/623.xalancbmk_s_ref+623.xalancbmk_s_ref \
				$(SPEC_BIN_DIR)/625.x264_s_ref+625.x264_s_ref \
				$(SPEC_BIN_DIR)/641.leela_s_ref+641.leela_s_ref \
				$(SPEC_BIN_DIR)/602.gcc_s_ref+602.gcc_s_1_ref \
				$(SPEC_BIN_DIR)/602.gcc_s_ref+602.gcc_s_2_ref \
				$(SPEC_BIN_DIR)/602.gcc_s_ref+602.gcc_s_3_ref \
				$(SPEC_BIN_DIR)/657.xz_s_ref+657.xz_s_docs_ref \
				$(SPEC_BIN_DIR)/657.xz_s_ref+657.xz_s_cld_ref \
				#$(SPEC_BIN_DIR)/603.bwaves_s_ref+603.bwaves_s_1_ref \
				$(SPEC_BIN_DIR)/603.bwaves_s_ref+603.bwaves_s_2_ref \
				$(SPEC_BIN_DIR)/628.pop2_s_ref+628.pop2_s_ref \
				$(SPEC_BIN_DIR)/648.exchange2_s_ref+648.exchange2_s_ref \
				$(SPEC_BIN_DIR)/621.wrf_s_ref+621.wrf_s_ref \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_spam_ref \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_diff_ref \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_split_ref \
				$(SPEC_BIN_DIR)/620.omnetpp_s_ref+620.omnetpp_s_ref \
				$(SPEC_BIN_DIR)/607.cactuBSSN_s_ref+607.cactuBSSN_s_ref \
				$(SPEC_BIN_DIR)/619.lbm_s_ref+619.lbm_s_ref \
				$(SPEC_BIN_DIR)/627.cam4_s_ref+627.cam4_s_ref \
				$(SPEC_BIN_DIR)/649.fotonik3d_s_ref+649.fotonik3d_s_ref \
				$(SPEC_BIN_DIR)/654.roms_s_ref+654.roms_s_ref \
				$(SPEC_BIN_DIR)/605.mcf_s_ref+605.mcf_s_ref \
				$(SPEC_BIN_DIR)/631_deepsjeng_s_ref+631.deepsjeng_s_ref \

## The benchmarks below fail
syscall_46 = \
				$(SPEC_BIN_DIR)/603.bwaves_s_test+603.bwaves_s_1_test \
				$(SPEC_BIN_DIR)/603.bwaves_s_test+603.bwaves_s_2_test \
				$(SPEC_BIN_DIR)/628.pop2_s_test+628.pop2_s_test \
				$(SPEC_BIN_DIR)/648.exchange2_s_test+648.exchange2_s_test \
				$(SPEC_BIN_DIR)/603.bwaves_s_ref+603.bwaves_s_1_ref \
				$(SPEC_BIN_DIR)/603.bwaves_s_ref+603.bwaves_s_2_ref \
				$(SPEC_BIN_DIR)/628.pop2_s_ref+628.pop2_s_ref \
				$(SPEC_BIN_DIR)/648.exchange2_s_ref+648.exchange2_s_ref \


syscall_49 = \
				$(SPEC_BIN_DIR)/600.perlbench_s_test+600.perlbench_s_test \
				$(SPEC_BIN_DIR)/620.omnetpp_s_test+620.omnetpp_s_test \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_spam_ref \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_diff_ref \
				$(SPEC_BIN_DIR)/600.perlbench_s_ref+600.perlbench_s_split_ref \
				$(SPEC_BIN_DIR)/620.omnetpp_s_ref+620.omnetpp_s_ref \

syscall_113 = \
				$(SPEC_BIN_DIR)/621.wrf_s_test+621.wrf_s_test \
				$(SPEC_BIN_DIR)/621.wrf_s_ref+621.wrf_s_ref \

malloc_error = \
				$(SPEC_BIN_DIR)/607.cactuBSSN_s_test+607.cactuBSSN_s_test \
				$(SPEC_BIN_DIR)/619.lbm_s_test+619.lbm_s_test \
				$(SPEC_BIN_DIR)/627.cam4_s_test+627.cam4_s_test \
				$(SPEC_BIN_DIR)/649.fotonik3d_s_test+649.fotonik3d_s_test \
				$(SPEC_BIN_DIR)/654.roms_s_test+654.roms_s_test \
				$(SPEC_BIN_DIR)/607.cactuBSSN_s_ref+607.cactuBSSN_s_ref \
				$(SPEC_BIN_DIR)/619.lbm_s_ref+619.lbm_s_ref \
				$(SPEC_BIN_DIR)/627.cam4_s_ref+627.cam4_s_ref \
				$(SPEC_BIN_DIR)/649.fotonik3d_s_ref+649.fotonik3d_s_ref \
				$(SPEC_BIN_DIR)/654.roms_s_ref+654.roms_s_ref \

segfault = \
				$(SPEC_BIN_DIR)/605.mcf_s_test+605.mcf_s_test \
				$(SPEC_BIN_DIR)/605.mcf_s_ref+605.mcf_s_ref \

assertion_failed = \
				$(SPEC_BIN_DIR)/631_deepsjeng_s_test+631.deepsjeng_s_test \
				$(SPEC_BIN_DIR)/631_deepsjeng_s_ref+631.deepsjeng_s_ref \

all_smpt_bmarks =	\
					$(smpt_spec_2k6_test_bmarks) \
					#$(smpt_spec_2k6_ref_bmarks) \
					#$(smpt_spec_2k17_test_bmarks) \
					$(smpt_spec_2k17_ref_bmarks) \
					$(syscall_46) \
					$(syscall_49) \
					$(syscall_113) \
					$(syscall_163) \
					$(malloc_error) \


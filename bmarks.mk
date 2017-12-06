# Path to the benchmark build directory (location of compiled binaries, ref_inputs etc.)
# If using Speckle to compile SPEC benchmakrs, provide the path to the Speckle build directory.
SPEC_BIN_DIR		= $(abspath ../../Speckle/build)
SPEC_JOBS_DIR		= $(abspath ./spec-jobs)

########################################################################
## Testcases for RTL simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way: 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+RTL_CONFIG_NAME+TEST_SUB_DIR+JOB_FILE_PATH+[OPTIONAL_CHECKPOINT_PATH]

all_rtl_tests =	\
				$(MICRO_SRC_DIR)/fibonacci/install+fibonacci+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/hello_world/install+hello_world+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/hellow_world/install+add_int+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/hello_world/install+reduce_array+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(MICRO_SRC_DIR)/branchy/install+brancy+Config1+$(MICRO_SRC_DIR)/fibonacci/job	\
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+Config1+$(SPEC_JOBS_DIR)/401.bzip2_test_job+-f$(BMARK_CHKPT_DIR)/401.bzip2_test/401.bzip2_test.3350

########################################################################
## Testcases for gate-level simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way: 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+RTL_CONFIG_NAME+TEST_SUB_DIR+JOB_FILE_PATH+[OPTIONAL_CHECKPOINT_PATH]

all_gate_tests =	$(all_rtl_tests)

########################################################################
## Testcases for Spike instruction set simulations
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way: 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+TEST_SUB_DIR+SPIKE_ARG1+SPIKE_ARG2+....

BMARK_CHKPT_DIR 	= $(SCRATCH_SPACE)/riscv_chkpts
all_spike_tests =	\
				$(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+335+-f$(BMARK_CHKPT_DIR)/401.bzip2_test/401.bzip2_test.335 \
				$(SPEC_BIN_DIR)/456.hmmer_test+456.hmmer_test+135+-f$(BMARK_CHKPT_DIR)/456.hmmer_test/456.hmmer_test.135 \
				$(SPEC_BIN_DIR)/458.sjeng_test+458.sjeng_test+143+-f$(BMARK_CHKPT_DIR)/458.sjeng_test/458.sjeng_test.143 \
				$(SPEC_BIN_DIR)/462.libquantum_test+462.libquantum_test+275+-f$(BMARK_CHKPT_DIR)/462.libquantum_test/462.libquantum_test.275 \
				$(SPEC_BIN_DIR)/464.h264ref_test+464.h264ref_test+120+-f$(BMARK_CHKPT_DIR)/464.h264ref_test/464.h264ref_test.120 \
				$(SPEC_BIN_DIR)/471.omnetpp_test+471.omnetpp_test+123+-f$(BMARK_CHKPT_DIR)/471.omnetpp_test/471.omnetpp_test.123 \
				$(SPEC_BIN_DIR)/473.astar_test+473.astar_test+187+-f$(BMARK_CHKPT_DIR)/473.astar_test/473.astar_test.187 \
				$(SPEC_BIN_DIR)/483.xalancbmk_test+483.xalancbmk_test+122+-f$(BMARK_CHKPT_DIR)/483.xalancbmk_test/483.xalancbmk_test.122 \
				$(SPEC_BIN_DIR)/410.bwaves_test+410.bwaves_test+212+-f$(BMARK_CHKPT_DIR)/410.bwaves_test/410.bwaves_test.212 \


########################################################################
## Testcases for generating Checkpoints on benchmarks
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way: 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME+CHECKPOINT_SKIP_AMT

chkpt_spec_2k6_test =	\
				$(SPEC_BIN_DIR)/445.gobmk_test+445.gobmk_test+335 \
				$(SPEC_BIN_DIR)/456.hmmer_test+456.hmmer_test+135 \
				$(SPEC_BIN_DIR)/458.sjeng_test+458.sjeng_test+143 \
				$(SPEC_BIN_DIR)/462.libquantum_test+462.libquantum_test+275 \
				$(SPEC_BIN_DIR)/464.h264ref_test+464.h264ref_test+120 \
				$(SPEC_BIN_DIR)/471.omnetpp_test+471.omnetpp_test+123 \
				$(SPEC_BIN_DIR)/473.astar_test+473.astar_test+187 \
				$(SPEC_BIN_DIR)/483.xalancbmk_test+483.xalancbmk_test+122 \
				$(SPEC_BIN_DIR)/410.bwaves_test+410.bwaves_test+212 \
				$(SPEC_BIN_DIR)/433.milc_test+433.milc_test+112 \
				$(SPEC_BIN_DIR)/437.leslie3d_test+437.leslie3d_test+186 \
				$(SPEC_BIN_DIR)/444.namd_test+444.namd_test+93 \
				$(SPEC_BIN_DIR)/453.povray_test+453.povray_test+65 \
				$(SPEC_BIN_DIR)/454.calculix_test+454.calculix_test+98 \
				$(SPEC_BIN_DIR)/465.tonto_test+465.tonto_test+123 \
				$(SPEC_BIN_DIR)/470.lbm_test+470.lbm_test+231 \
				$(SPEC_BIN_DIR)/481.wrf_test+481.wrf_test+143 \
				$(SPEC_BIN_DIR)/403.gcc_test+403.gcc_test+127 \
				$(SPEC_BIN_DIR)/416.gamess_test+416.gamess_test+342 \
				$(SPEC_BIN_DIR)/434.zeusmp_test+434.zeusmp_test+267 \
				$(SPEC_BIN_DIR)/435.gromacs_test+435.gromacs_test+156 \
				$(SPEC_BIN_DIR)/436.cactusADM_test+436.cactusADM_test+112 \
				$(SPEC_BIN_DIR)/450.soplex_test+450.soplex_test+123 \
				$(SPEC_BIN_DIR)/459.gemsFDTD_test+459.gemsFDTD_test+132 \
				$(SPEC_BIN_DIR)/482.sphinx3_test+482.sphinx3_test+108 \

chkpt_spec_2k6_ref =	\
				$(SPEC_BIN_DIR)/445.gobmk_ref+445.gobmk_ref+335 \
				$(SPEC_BIN_DIR)/456.hmmer_ref+456.hmmer_ref+135 \
				$(SPEC_BIN_DIR)/458.sjeng_ref+458.sjeng_ref+143 \
				$(SPEC_BIN_DIR)/462.libquantum_ref+462.libquantum_ref+275 \
				$(SPEC_BIN_DIR)/464.h264ref_ref+464.h264ref_ref+120 \
				$(SPEC_BIN_DIR)/471.omnetpp_ref+471.omnetpp_ref+123 \
				$(SPEC_BIN_DIR)/473.astar_ref+473.astar_ref+187 \
				$(SPEC_BIN_DIR)/483.xalancbmk_ref+483.xalancbmk_ref+122 \
				$(SPEC_BIN_DIR)/410.bwaves_ref+410.bwaves_ref+212 \
				$(SPEC_BIN_DIR)/433.milc_ref+433.milc_ref+112 \
				$(SPEC_BIN_DIR)/437.leslie3d_ref+437.leslie3d_ref+186 \
				$(SPEC_BIN_DIR)/444.namd_ref+444.namd_ref+93 \
				$(SPEC_BIN_DIR)/453.povray_ref+453.povray_ref+65 \
				$(SPEC_BIN_DIR)/454.calculix_ref+454.calculix_ref+98 \
				$(SPEC_BIN_DIR)/465.tonto_ref+465.tonto_ref+123 \
				$(SPEC_BIN_DIR)/470.lbm_ref+470.lbm_ref+231 \
				$(SPEC_BIN_DIR)/481.wrf_ref+481.wrf_ref+143 \
				$(SPEC_BIN_DIR)/403.gcc_ref+403.gcc_ref+127 \
				$(SPEC_BIN_DIR)/416.gamess_ref+416.gamess_ref+342 \
				$(SPEC_BIN_DIR)/434.zeusmp_ref+434.zeusmp_ref+267 \
				$(SPEC_BIN_DIR)/435.gromacs_ref+435.gromacs_ref+156 \
				$(SPEC_BIN_DIR)/436.cactusADM_ref+436.cactusADM_ref+112 \
				$(SPEC_BIN_DIR)/450.soplex_ref+450.soplex_ref+123 \
				$(SPEC_BIN_DIR)/459.gemsFDTD_ref+459.gemsFDTD_ref+132 \
				$(SPEC_BIN_DIR)/482.sphinx3_ref+482.sphinx3_ref+108 \


all_chkpts =	\
					$(chkpt_spec_2k6_test) \
					$(chkpt_spec_2k17_test) \
					$(chkpt_spec_2k6_ref) \
					$(chkpt_spec_2k17_ref) \

########################################################################
## Testcases for running Simpoints on benchmarks
########################################################################

## Testcases are a combination of a few parameters to be used for the run. 
## All tests are run in scratchspace in a benchmark specific subdirectory
## A testcase specific subdirectory in the benchmark subdirectory can be 
## provided in the testcase definition. A testcase can be specified in the
## following way: 
## BENCHMARK_BINARY_DIR+BENCHMARK_NAME

smpt_spec_2k6_test_bmarks =	\
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_test \
				$(SPEC_BIN_DIR)/429.mcf_ref+429.mcf_test \
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
				$(SPEC_BIN_DIR)/481.wrf_test+481.wrf_test \
				## The following benchmarks do not simulate correctly \
				$(SPEC_BIN_DIR)/403.gcc_test+403.gcc_test \
				$(SPEC_BIN_DIR)/403.gcc_test+403.gcc_test \
				$(SPEC_BIN_DIR)/416.gamess_test+416.gamess_test \
				$(SPEC_BIN_DIR)/434.zeusmp_test+434.zeusmp_test \
				$(SPEC_BIN_DIR)/435.gromacs_test+435.gromacs_test \
				$(SPEC_BIN_DIR)/436.cactusADM_test+436.cactusADM_test \
				$(SPEC_BIN_DIR)/450.soplex_test+450.soplex_test \
				$(SPEC_BIN_DIR)/459.gemsFDTD_test+459.gemsFDTD_test \
				$(SPEC_BIN_DIR)/482.sphinx3_test+482.sphinx3_test \

smpt_spec_2k6_ref_bmarks =	\
				$(SPEC_BIN_DIR)/401.bzip2_ref+401.bzip2_ref \
				$(SPEC_BIN_DIR)/429.mcf_ref+429.mcf_ref \
				$(SPEC_BIN_DIR)/445.gobmk_ref+445.gobmk_ref \
				$(SPEC_BIN_DIR)/456.hmmer_ref+456.hmmer_ref \
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
				$(SPEC_BIN_DIR)/481.wrf_ref+481.wrf_ref \
				## The following benchmarks do not simulate correctly \
				$(SPEC_BIN_DIR)/400.perlbench_ref+400.perlbench_ref \
				$(SPEC_BIN_DIR)/403.gcc_ref+403.gcc_ref \
				$(SPEC_BIN_DIR)/416.gamess_ref+416.gamess_ref \
				$(SPEC_BIN_DIR)/434.zeusmp_ref+434.zeusmp_ref \
				$(SPEC_BIN_DIR)/435.gromacs_ref+435.gromacs_ref \
				$(SPEC_BIN_DIR)/436.cactusADM_ref+436.cactusADM_ref \
				$(SPEC_BIN_DIR)/447.dealII_ref+447.dealII_ref \
				$(SPEC_BIN_DIR)/450.soplex_ref+450.soplex_ref \
				$(SPEC_BIN_DIR)/459.gemsFDTD_ref+459.gemsFDTD_ref \
				$(SPEC_BIN_DIR)/482.sphinx3_ref+482.sphinx3_ref \


all_smpt_bmarks =	\
					$(smpt_spec_2k6_test_bmarks) \
					$(smpt_spec_2k17_test_bmarks) \
					$(smpt_spec_2k6_ref_bmarks) \
					$(smpt_spec_2k17_ref_bmarks) \

User Guide for AnyCore RISC-V Test Infrastructure
===========================================================================

1. [Quickstart](#quickstart)
2. [Organization of the Test Infra](#organization)
3. [Run Functional Simulator Tests](#functional-sim)
4. [Run RTL Simulations](#rtl-sim)
5. [Gather Simpoints](#simpoints)
6. [Create Checkpoints](#checkpoints)

# <a name="quickstart"></a>Quickstart
This has the regression test environment and testcases for the AnyCore RTL and
Spike RISC-V functional simulator. The infrastructure is make driven and can use 
parallel make to run multiple simulatios in parallel. Simulations are run in a
scratch space to allow different runs from clobbering each other. Follow these 
steps to run the regression:

1. Edit the path of scratch space where you want to run the regression. This
is in Makefile. Modify the variable "SCRATCH_SPACE" to point to your scratch
storage. It is recommended to use local storage for running the regression since
running it in NFS or AFS storage can slow the regressions down.
By default, SCRATCH_SPACE = ../scratch

2. Add or remove testcases in the bmarks.mk file. For RTL testcases, modify the variable
"all_rtl_tests". For gate-level testcases, modify the variable "all_gate_tests". For Spike
simulations modify all_spike_tests. Some examples are already present in bmarks.mk. Be careful
to use correct make syntax and tabs instead of spaces.

3. Use the make target that you want to run. Following make targets are available:

    % make rtl   #Runs the specified testcases on the RTL
    % make gate  #Runs the specified testcases on the gate-level netlist
    % make spike #Runs the specified testcases on Spike functional simulator

# <a name="organization"></a>Overview of the Test Infra

## Important Directories and Files
The directories and their descriptions are as follows:
* `benchmakrs`: Contains a few microbenchmarks and infrastructure to build these micrbenchmarks
* `scripts`: Contains scripts used for setting up test directories and run areas
* `spec-jobs`: Contains example `job` files for RTL and gate-level simulations of SPEC benchmarks

The following files are relevant for configuring and running simulations:
* `Makefile`: Contains the parent make rules for setting up and running simulations
* `bmarks.mk`: Specifies testcases for RTL, gate-level, and Spike tests. Also contains testcases
for gathering Simpoints and creating benchmark checkpoints
* `spike.mk`: Makefile containing the rules for individual benchmarks (SPEC 2006, SPEC 2017 etc.)
* `rtl.mk`: The parent rule for running RTL simulation uses this file as a template to generate 
the Makefile (in the simulation directory) for running RTL simulation
* `gate.mk`: The parent rule for running gate-level simulation uses this file as a template to generate 
the Makefile (in the simulation directory) for running gate-level simulation

## Make rules and Testcases
The test environment uses MAKE macro definitions to specify rules. Each rule is called for all testcases
enabled in the bmakrs.mk file and can be run using parallel make.
A testcase is a combination of a few parameters separated by a `+`. For example, the testcase below specifies a
Spike test using a checkpoint.

    $(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+335+-f$(BMARK_CHKPT_DIR)/401.bzip2_test/401.bzip2_test.335

This testcase has 4 parameters separated by +. The parameters are as follows:

* `$(SPEC_BIN_DIR)/401.bzip2_test` -> Specifies the path of the directory that contains the binary and input files
* `401.bzip2_test` -> Specifies the benchmark name. This is used to create run directories in the scratch space
* `335`            -> Specifies the name of a test for the benchmark. This is used to create subdirectory within the run directory for the benchmark In this example, the skip amount of the checkpoint is used as the testname.
* `-f$(BMARK_CHKPT_DIR)/401.bzip2_test/401.bzip2_test.335`-> Path of the checkpoint file used to restore the simulation 
state (`-f` is a Spike flag)

# <a name="functional-sim"></a>Run Functional Simulator (Spike)

## <a name="micro"></a>Run Microbenchmarks

Some microbenchmarks are already available in the "benchmarks" folder. You
can use one of the existing microbenchmark as a template to add new microbenchmarks
in the folder. Don't forget to also add the microbenchmark name in benchmarks/Makefile
so that it can be built.

Build the microbenchmarks by running:

    % make micro-build

Then add the testcase to "all_spike_tests" in bmarks.mk. Follow the examples
in the file to add new testcases. You can then run the testcases using:

    % make spike

## Build SPEC using Speckle

It is recommended to use Speckle (https://github.com/anycore/Speckle) to build SPEC
benchmarks. Follow the README in Speckle to build SPEC 2006 and SPEC 2017 benchmarks.

## Run full benchmarks

Once the benchmarks are built, modify the
SPEC_BIN_DIR in bmarks.mk to point to your Speckle build directory. You can then run
existing testcases present in bmarks.mk (you might have to remove the checkpoint file from the testcase
since they might not exist yet).

## Adding new testcases

Follow the examples to add additional testcases. Benchamrks other than SPEC can also be added in a similar way
by first building the benchmarks and then adding a testcase with the benchmark path and benchmark name.

# <a name="rtl-sim"></a>Run RTL Simulation (Similar steps for gate-level simulation)
## Run Microbenchmarks
Refer to [Spike Microbenchmark section](#micro) to learn how to build the microbenchmarks. Once you have
built them, add new testcases to "all_rtl_tests" in bmarks.mk. Follow the examples in the file.
You can then run the testcases using:

    % make rtl

## Build and run SPEC using Speckle
It is recommended to use Speckle (https://github.com/anycore/Speckle) to build SPEC
benchmarks. Follow the README in Speckle to build SPEC 2006 and SPEC 2017 benchmarks. 
Once the benchmarks are built, modify the
SPEC_BIN_DIR in bmarks.mk to point to your Speckle build directory. bmarks.mk contains 
example testcases for running benchmarks (SPEC etc.), using a checkpoint and not using one,
on the RTL. New testcases can be easily added following these examples after building the benchmark.

## Adding new benchmarks and testcases

Follow the examples to add additional testcases. Benchamrks other than SPEC can also be added in a similar way
by first building the benchmarks and then adding a testcase with the benchmark path and benchmark name.

# <a name="simpoints"></a>Gather Simpoints
## What are Simpoints
## Gathering Simpoint for a new benchmark

# <a name="checkpoints"></a>Create Checkpoints
## What are checkpoints
## Generating checkpoints
Checkpoints are created using Spike and requires passing the `-c` flag to Spike along the skip amount at which the 
checkpoint needs to be created. This can be done manually. However, the automated test infrastructure has specific 
make rules and testcases that can be used to create checkpoints much more easily. The testcases are specified in the
bmarks.mk file. Take a look at the variable `all_chkpts`. You can specify as many checkpoint testcases as you want.
Following is an example testcase for checkpoint creation:

all_chkpts = $(SPEC_BIN_DIR)/401.bzip2_test+401.bzip2_test+38


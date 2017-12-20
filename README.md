User Guide for AnyCore RISC-V Test Infrastructure
===========================================================================

1. [Quickstart](#quickstart)
2. [Organization of the Test Infra](#organization)
2. [Run Functional Simulator Tests](#functional-sim)
2. [Run RTL Simulations](#rtl-sim)
3. [Gather Simpoints](#build-tools)

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

# <a name="organization"></a>Organization of the Test Infra

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
benchmarks. Follow the README in Speckle. 

## Run full bbenchmarks

Once the benchmarks are built, modify the
SPEC_BIN_DIR in bmarks.mk to point to your Speckle build directory. You can then run
existing testcases present in bmarks.mk (you might have to remove the checkpoint file from the testcase
since they might not exist yet).

## Adding new testcases

Follow the examples to add additional testcases.

# <a name="rtl-sim"></a>Run RTL Simulation
## Run Microbenchmarks
Refer to [Spike Microbenchmark section](#micro) to learn how to build the microbenchmarks. Once you have
built them, add new testcases to "all_rtl_tests" in bmarks.mk. Follow the examples in the file.
You can then run the testcases using:

    % make rtl

## Build and run SPEC using Speckle
Once the benchmarks are built, modify the
SPEC_BIN_DIR in bmarks.mk to point to your Speckle build directory. You can then run
existing testcases present in bmarks.mk (you might have to remove the checkpoint file from the testcase
since they might not exist yet).

## Adding new benchmarks and testcases

Follow the examples to add additional testcases.

# <a name="simpoints"></a>Gather Simpoints
## What are Simpoints
## Gathering Simpoint for a new benchmark

# <a name="checkpoints"></a>Create Checkpoints
## What are checkpoints
## Generating new checkpoints


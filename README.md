# anycore-tests
This has the regression test environment and testcases for the AnyCore RTL
Follow these steps to run the regression:

1. Edit the path of scratch space where you want to run the regression. This
is in Makefile. Modify the variable "SCRATCH_SPACE" to point to your scratch
storage. It is recommended to use local storage for running the regression since
running it in NFS or AFS storage can slow the regressions down.
By default, SCRATCH_SPACE = ../scratch

2. Add or remove testcases in the Makefile. For RTL testcases, modify the variable
"all_rtl_tests". For gate-level testcases, modify the variable "all_gate_tests". Some
examples are already present in the Makefile

3. Use the make target that you want to run. Following make targets are available:
make rtl  - Runs the specified tests on the RTL
make gate - Runs the specified tests on the gate-level netlist


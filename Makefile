PERFORMANCE_PATH=./performance
VALID_PATH=./validation


F_TESTS = $(wildcard *.f90)

F_EXES  = $(F_TESTS:.f90=.x)

EXES    = $(F_EXES)


.PHONY: help performance validation

all: help


performance:
	@cd $(PERFORMANCE_PATH); $(MAKE) -s $(TEST) EMAIL=$(EMAIL)


validation:
	@cd $(VALID_PATH); $(MAKE) -s $(TEST) EMAIL=$(EMAIL)


clean: performance-clean validation-clean


performance-clean:



validation-clean:
	@cd $(VALID_PATH); $(MAKE) -s clean-all


help default:
	@printf '\n\n%10s\n\n' "HPC Tools CAF- test suite"
	@printf '%s\n\n' "Usage: $(MAKE) <performance | validation> [<primary options> <secondary options>    ]"
	@printf '%s\n' "---------VALIDATION TEST SUITE-------------"
	@printf '\n%10s\n' " Usage: $(MAKE) validation TEST=[OPTIONS] [EMAIL=<yes/no>]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ all:" " tests for conformance, fault-tolerance and confidence tests"
	@printf '%-20s%-90s\n' " |_ few-tests:" " tests only those listed in the file "test_file" under ./few directory"
	@printf '%-20s%-90s\n' " |_ conformance:" " tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ confidence:" " performs cross-testing to test support for non-determinism handling constructs"
	@printf '%-20s%-90s\n' " |_ fault:" " tests for verification of fault handling constructs"
	@printf '%-20s%-90s\n' " |_ clean:" " Cleans everything - results, tests-history, compiler-logs, runtime-logs"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"
	@printf '%s\n' "---------PERFORMANCE TEST SUITE-------------"
	@printf '\n%10s\n' " Usage: $(MAKE)  performance ARGS=[OPTIONS]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ compile_<suite>:" "compiles and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ run_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ clean_<suite>:" "cleans up the logs, executables and all previous history of the regression runs"
	@printf '%-20s%-90s\n' " |_ <suite>:" "[npb | microbenchmarks | kernels]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"


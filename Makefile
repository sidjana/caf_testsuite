PERFORMANCE_PATH=./performance
VALID_PATH=./validation


F_TESTS = $(wildcard *.f90)

F_EXES  = $(F_TESTS:.f90=.x)

EXES    = $(F_EXES)


.PHONY: help performance validation



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
	@printf '%-20s%-90s\n' " |_ all:" " tests both - conformance and non-conformance tests"
	@printf '%-20s%-90s\n' " |_ few-tests:" " tests only those listed in the file "test_file" under ./few directory"
	@printf '%-20s%-90s\n' " |_ conformance:" " tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ non-conformance:" " tests for compile/runtime verifications in accordance with the standard"
	@printf '%-20s%-90s\n' " |_ clean:" " [-results|-tests-history|-compiler-logs|-runtime-logs|-all]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"

all: help

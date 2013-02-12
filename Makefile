PERFORMANCE_PATH=./performance
VALID_PATH=./validation

TEMP=$(shell cd $(VALID_PATH)/config; ./config2makedef.sh)
TEMP=$(shell cd $(PERFORMANCE_PATH)/support; ./config2makedef.sh)

.PHONY: help performance validation


all help default:
	@printf '\n\n%10s\n\n' "HPCTools CAF - test suite"
	@printf '%s\n\n' "Usage: $(MAKE) <performance | validation | clean> <primary options>"
	@printf '%s\n\n' "---------VALIDATION TEST SUITE-------------"
	@printf '%10s\n' "Usage: $(MAKE) validation TEST=<OPTIONS>"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ all:" "tests for conformance, fault-tolerance and confidence tests"
	@printf '%-20s%-90s\n' " |_ few-tests:" "tests only those listed in the file "test_file" under ./few directory"
	@printf '%-20s%-90s\n' " |_ feature:" "tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ confidence:" "performs cross-testing to test support for non-determinism handling constructs"
	@printf '%-20s%-90s\n' " |_ fault:" "tests for verification of fault handling constructs"
	@printf '%-20s%-90s\n' " |_ clean-all:" "Cleans everything - results, tests-history, compiler-logs, runtime-logs"
	@printf '%-20s%-90s\n\n' " |_ help:" "displays this message"
	@printf '%s\n' "---------PERFORMANCE TEST SUITE-------------"
	@printf '\n%10s\n' "Usage: $(MAKE)  performance ARGS=<OPTIONS>"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ compile_<suite>:" "compiles and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ run_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ complete_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ clean-all:" "cleans up the logs, executables and all previous history of the regression runs"
	@printf '%-20s%-90s\n' " |_ <suite>:" "[performance | npb | microbenchmarks | kernels]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"


performance:
	@cd $(PERFORMANCE_PATH); $(MAKE) -s $(TEST) 


validation:
	@cd $(VALID_PATH); $(MAKE) -s $(TEST) 


clean: performance-clean validation-clean


performance-clean:
	@cd $(PERFORMANCE_PATH); $(MAKE) -s clean-all


validation-clean:
	@cd $(VALID_PATH); $(MAKE) -s clean-all


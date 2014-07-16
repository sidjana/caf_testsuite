SHELL := /bin/bash
PERFORMANCE_PATH=./performance
VALID_PATH=./validation

TEMP=$(shell cd config; ./config2makedef.sh)

.PHONY: help performance validation


all help default:
	@printf '\n\n%10s\n\n' "CAF Validation and Performance Test Suites"
	@printf '%s\n%s\n\n' "If the tests are executed from this root directory of the test suite, then" "USAGE: $(MAKE) [performance | validation | clean] PARAMS=<OPTIONS>"
	@printf '%s\n\n' "---------OPTIONS for VALIDATION TEST SUITE-------------"
	@cd $(VALID_PATH); $(MAKE) -s help
	@printf '%s\n' "---------OPTIONS for PERFORMANCE TEST SUITE-------------"
	@cd $(PERFORMANCE_PATH); $(MAKE) -s help


performance:
	@cd $(PERFORMANCE_PATH); $(MAKE) -s $(PARAMS)


validation:
	@cd $(VALID_PATH); $(MAKE) -s $(PARAMS)


clean cleanall: performance-clean validation-clean
	@rm -rf config/make-compiler.* config/make.def config/make-validation.def


performance-clean:
	@cd $(PERFORMANCE_PATH); $(MAKE) -s cleanall


validation-clean:
	@cd $(VALID_PATH); $(MAKE) -s cleanall


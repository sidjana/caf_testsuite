SHELL := /bin/bash

.PHONY: all feature non-conformance crosschecked_feature few-tests help

TEMP_1:=$(shell ./config/config2makedef.sh)  # generate make.def from CONFIG
include ./config/make.def   # auto-generated

help :
	@echo -e "If test suite is run from within validation directory, then USAGE: $(MAKE) OPTIONS \n OPTIONS include:"
	@printf '%-30s\n'      " |  (Note: <suite> = fewtests | feature | crosschecked_feature | status )"
	@printf '%-30s\n'      " |  "
	@printf '%-30s%-90s\n' " |_ all:" "all validation tests"
	@printf '%-30s%-90s\n' " |_ fewtests:" "tests only those listed in the file "test_file" under ./few directory"
	@printf '%-30s%-90s\n' " |_ feature:" "tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-30s%-90s\n' " |_ crosschecked_feature:" "performs cross-testing to test support for non-determinism handling constructs"
	@printf '%-30s%-90s\n' " |_ status:" "tests for verifying handling of status returned by certain statements"
	@printf '%-30s%-90s\n' " |_ clean<suite>:" "Cleans executables"
	@printf '%-30s%-90s\n' " |_ cleanall:" "Cleans everything - results, tests-history, compiler-logs, runtime-logs"
	@printf '\n%-20s\n\n' "Before running the tests, ensure that the CONFIG file with the required parameters are set in validation/config directory."


all:  feature crosschecked_feature status


feature:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s  all;


feature-header:
	@printf '\n%s\n%s\n' "-------------------- CAF FEATURE TESTS ----------------------"  \
	   				"Evaluating $(COMPILER)"
	@printf '%-20s\t%-70s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


crosschecked_feature:
	@cd $(CC_FEATURE_TEST_PATH); $(MAKE) -s all;


crosschecked_feature-header:
		@printf '\n%s\n%s\n' "----------- CAF CROSS-CHECKED FEATURE TESTS --------------"  \
                    "Evaluating $(COMPILER)"
	   	@ printf '%-18s\t%-60s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CROSS CHECK"



nonconformance:
	@cd $(NONCONF_TEST_PATH); $(MAKE) -s all


nonconformance-header:
		@printf '\n%s\n%s\n' "-------------------- CAF NONCONFORMANCE TESTS ----------------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


status:
	@cd $(STATUS_TEST_PATH); $(MAKE) -s all


status-header:
		@printf '\n%s\n%s\n' "----------------------- CAF STATUS TESTS --------------------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-70s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"



fewtests:
	@cd $(FEW_TEST_PATH); $(MAKE) -s  all



clean:
	@ printf '%s\n' " $(MAKE) cleanall|clean_output|clean_exec|clean_history"



cleanfewtests:
	@cd $(FEW_TEST_PATH); $(MAKE) -s clean_exec;

cleanfeature:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s clean_exec;

cleancrosschecked_feature:
	@cd $(CC_FEATURE_TEST_PATH); $(MAKE) -s clean_exec;

cleanstatus:
	@cd $(STATUS_TEST_PATH); $(MAKE) -s clean_exec;

cleanall clean_output clean_exec clean_history:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(FEW_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(CC_FEATURE_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(STATUS_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@if [ "$@" == "cleanall" ];  then \
		rm -rf ./bin/*.* , *.mod; rm -rf ./config/make.def ; \
	 fi;


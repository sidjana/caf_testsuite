SHELL := /bin/bash

.PHONY: all feature non-conformance confidence few-tests help

TEMP_1:=$(shell ./config/config2makedef.sh)  # generate make.def from CONFIG
include ./config/make.def   # auto-generated

help :
	@echo -e "If test suite is run from within validation directory, then USAGE: $(MAKE) OPTIONS \n OPTIONS include:"
	@printf '%-20s\n'      " |  (Note: <suite> = fewtests | feature | confidence | fault )"
	@printf '%-20s\n'      " |  "
	@printf '%-20s%-90s\n' " |_ all:" "tests for conformance, fault-tolerance and confidence tests"
	@printf '%-20s%-90s\n' " |_ fewtests:" "tests only those listed in the file "test_file" under ./few directory"
	@printf '%-20s%-90s\n' " |_ feature:" "tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ confidence:" "performs cross-testing to test support for non-determinism handling constructs"
	@printf '%-20s%-90s\n' " |_ fault:" "tests for verification of fault handling constructs"
	@printf '%-20s%-90s\n' " |_ clean<suite>:" "Cleans executables"
	@printf '%-20s%-90s\n' " |_ cleanall:" "Cleans everything - results, tests-history, compiler-logs, runtime-logs"
	@printf '\n%-20s\n\n' "Before running the tests, ensure that the CONFIG file with the required parameters are set in validation/config directory."


all:  feature confidence  fault


feature:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s  all;


feature-header:
	@printf '\n%s\n%s\n' "---------------HPC Tools CAF FEATURE testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	@printf '%-20s\t%-70s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


confidence:
	@cd $(CONF_TEST_PATH); $(MAKE) -s all;


confidence-header:
		@ printf '\n%s\n%s\n\n' "---------------HPC Tools CAF CONFIDENCE testsuite---------------" \
                    "Evaluating $(COMPILER)"
	   	@ printf '%-18s\t%-60s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CONFIDENCE"



nonconformance:
	@cd $(NONCONF_TEST_PATH); $(MAKE) -s all


nonconformance-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF NON-CONFORMANCE testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


fault:
	@cd $(FAULT_TEST_PATH); $(MAKE) -s all


fault-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF FAULT testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-70s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"



fewtests:
	@cd $(FEW_TEST_PATH); $(MAKE) -s  all



clean:
	@ printf '%s\n' " $(MAKE) clean_output|clean_exec|clean_history|cleanall>"



cleanfewtests:
	@cd $(FEW_TEST_PATH); $(MAKE) -s clean_exec;

cleanfeature:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s clean_exec;

cleanconfidence:
	@cd $(CONF_TEST_PATH); $(MAKE) -s clean_exec;

cleanfault:
	@cd $(FAULT_TEST_PATH); $(MAKE) -s clean_exec;

cleanall:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(FEW_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(CONF_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(FAULT_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@if [ "$@" == "cleanall" ];  then \
		rm -rf ./bin/*.* , *.mod; rm -rf ./config/make.def ; \
	 fi;


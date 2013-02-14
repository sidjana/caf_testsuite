
.PHONY: all feature non-conformance confidence few-tests help

TEMP_1:=$(shell ./config/config2makedef.sh)  # generate make.def from CONFIG
include ./config/make.def   # auto-generated

help : 
	@echo "For testing: $(MAKE) [all | feature | non-conformance | confidence | fault | few-tests | help ] "
	@echo -n "For cleanup:"; $(MAKE) -s clean


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



non-conformance:
	@cd $(NONCONF_TEST_PATH); $(MAKE) -s all


non-conformance-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF NON-CONFORMANCE testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


fault:
	@cd $(FAULT_TEST_PATH); $(MAKE) -s all


fault-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF FAULT testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-70s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"



few-tests:
	@cd $(FEW_TEST_PATH); $(MAKE) -s  all



clean:
	@ printf '%s\n' " $(MAKE) clean<_output | _exec | _history | all>"


clean_output clean_exec clean_history cleanall:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(CONF_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(FEW_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@cd $(FAULT_TEST_PATH); $(MAKE) -s $@; cd .. ;
	@if [ "$@" == "clean-all" ];  then \
		rm -rf ./bin/*.* , *.mod; rm -rf ./config/make.def ; \
	 fi;


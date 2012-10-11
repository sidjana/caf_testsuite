include ./config/make.def


.PHONY: all conformance non-conformance confidence few


all: conformance confidence  fault


conformance:
	@cd $(FEATURE_LOG_PATH); $(MAKE) -s  all;


conformance-header:
	@printf '\n%s\n%s\n' "---------------HPC Tools CAF CONFORMANCE testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	@printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


confidence:
	@cd $(CONF_LOG_PATH); $(MAKE) -s all;


confidence-header:
		@ printf '\n%s\n%s\n\n' "---------------HPC Tools CAF CONFIDENCE testsuite---------------" \
                    "Evaluating $(COMPILER)"
	   	@ printf '%-15s\t%-50s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CONFIDENCE"



non-conformance:
	@cd $(NONCONF_LOG_PATH); $(MAKE) -s all


non-conformance-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF NON-CONFORMANCE testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"


fault:
	@cd $(FAULT_LOG_PATH); $(MAKE) -s all


fault-header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF FAULT testsuite---------------"  \
	   				"Evaluating $(COMPILER)"
	   @printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"



few-tests:
	@cd $(FEW_LOG_PATH); $(MAKE) -s  all


clean-all:
	@cd $(FEATURE_LOG_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd confidence_tests; $(MAKE) -s clean-all; cd .. ;
	@cd should_fail; $(MAKE) -s clean-all; cd .. ;
	@cd few_tests; $(MAKE) -s clean-all; cd .. ;
	@cd fault_tests; $(MAKE) -s clean-all; cd .. ;
	@rm -rf *.mod


clean:
	@ printf '%s\n%s\n' "Usage:" "$$ $(MAKE) clean-<output | exec | history | all>"


default:
	@echo "Usage: $(MAKE) [all | conformance | non-conformance | confidence | fault | few-tests] "



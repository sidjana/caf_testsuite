include ./config/make.def

.PHONY: all feature non-conformance confidence few


default help :
	@echo "For testing: $(MAKE) [all | feature | non-conformance | confidence | fault | few-tests ] "
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
	@ printf '%s %s\n' " use" " $(MAKE) clean-<output | exec | history | all>"


clean-all:
	@cd $(FEATURE_TEST_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd $(CONF_TEST_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd $(FEW_TEST_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd $(FAULT_TEST_PATH); $(MAKE) -s clean-all; cd .. ;
	@rm -rf *.mod ./bin/*


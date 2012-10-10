include ./config/make.def


.PHONY: all conformance non-conformance confidence few


all: conformance confidence non-conformance few-tests


conformance:
	@cd $(FEATURE_LOG_PATH); $(MAKE)  all;


confidence:
	@cd $(CONF_LOG_PATH); $(MAKE) all;


non-conformance:
	@cd $(NONCONF_LOG_PATH); $(MAKE) all


few-tests:
	@cd $(FEW_LOG_PATH); $(MAKE)  all


clean-all:
	@cd $(FEATURE_LOG_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd confidence_tests; $(MAKE) -s clean-all; cd .. ;
	@cd should_fail; $(MAKE) -s clean-all; cd .. ;
	@cd few_tests; $(MAKE) -s clean-all; cd .. ;
	@rm -rf *.mod


clean:
	@ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"




default:
	@echo "Usage: $(MAKE) [all | conformance | non-conformance | confidence | few-tests] "



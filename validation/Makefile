include ./config/make.def

default:
	@echo "Usage: $(MAKE) [all | conformance | non-conformance | confidence | few-tests] "


.PHONY: all conformance non-conformance confidence few


all: conformance confidence non-conformance few-tests


conformance:
	@cd $(FEATURE_LOG_PATH); $(MAKE) all;


confidence:
	@cd $(CONF_LOG_PATH); $(MAKE) all;


non-conformance:
	@cd $(NONCONF_LOG_PATH); $(MAKE) all


few-tests:
	@cd $(FEW_LOG_PATH); $(MAKE) all


clean-all:
	@cd $(FEATURE_LOG_PATH); $(MAKE) clean-all; cd .. ;
	@cd confidence_tests; $(MAKE) clean-all; cd .. ;
	@cd should_fail; $(MAKE) clean-all; cd .. ;
	@cd few_tests; $(MAKE) clean-all; cd .. ;
	@rm -rf *.mod


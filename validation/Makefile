include ./config/make.def

default:
	@echo "Usage: $(MAKE) [all | conformance | non-conformance | confidence | few-tests] "


.PHONY: all conformance non-conformance confidence few


all: conformance confidence non-conformance few-tests


conformance:
	@cd $(FEATURE_LOG_PATH); $(MAKE) -s all;


confidence:
	@cd $(CONF_LOG_PATH); $(MAKE) -s all;


non-conformance:
	@cd $(NONCONF_LOG_PATH); $(MAKE) -s all


few-tests:
	@cd $(FEW_LOG_PATH); $(MAKE) -s all


clean-all:
	@cd $(FEATURE_LOG_PATH); $(MAKE) -s clean-all; cd .. ;
	@cd confidence_tests; $(MAKE) -s clean-all; cd .. ;
	@cd should_fail; $(MAKE) -s clean-all; cd .. ;
	@cd few_tests; $(MAKE) -s clean-all; cd .. ;
	@rm -rf *.mod


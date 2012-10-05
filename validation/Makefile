include ./config/make.def

default: all


.PHONY: all conformance non-conformance confidence few


all: conformance non-conformance


conformance:
	@cd $(FEATURE_LOG_PATH); $(MAKE) all;


confidence:
	@cd $(CONF_LOG_PATH); $(MAKE) all;


non-conformance:
	@cd should_fail; $(MAKE) all


few_tests:
	@cd $(FEW_LOG_PATH); $(MAKE) all


clean-all:
	@cd $(FEATURE_LOG_PATH); $(MAKE) clean-all; cd .. ;
	@cd confidence_tests; $(MAKE) clean-all; cd .. ;
	@cd should_fail; $(MAKE) clean-all; cd .. ;
	@cd few_tests; $(MAKE) clean-all; cd .. ;
	@rm -rf *.mod


few:
	@ cd few; $(MAKE) FILE=$(FILE);



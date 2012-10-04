include ./config/make.def

default: help


.PHONY: all conformance non-conformance confidence few


all: conformance non-conformance


conformance:
	@cd should_pass; $(MAKE) all;


confidence:
	@cd confidence_tests; $(MAKE) all;


non-conformance:
	@cd should_fail; $(MAKE) all


clean clean-all:
	@cd should_pass; $(MAKE) clean; cd .. ;
	@cd confidence_tests; $(MAKE) clean; cd .. ;
	@cd should_fail; $(MAKE) clean; cd .. ;
	@cd few_tests; $(MAKE) clean; cd .. ;
	@rm -rf *.mod


few:
	@ cd few; $(MAKE) FILE=$(FILE);



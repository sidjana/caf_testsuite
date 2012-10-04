include ./config/make.def

default: help

help:
	@printf '\n%10s\n' " This is the CAF-validation test suite"
	@printf '\n%10s\n' " Usage: $(MAKE) validation TEST=[OPTIONS] [EMAIL=<yes/no>]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ all:" " tests both - conformance and non-conformance tests"
	@printf '%-20s%-90s\n' " |_ few:" " tests only those listed in the file "test_file" under ./few directory"
	@printf '%-20s%-90s\n' " |_ conformance:" " tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ non-conformance:" " tests for compile/runtime verifications in accordance with the standard"
	@printf '%-20s%-90s\n' " |_ clean:" " [-results|-tests-history|-compiler-logs|-runtime-logs|-all]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"


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



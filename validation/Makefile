include ../config/make.def

default: help

help:
	@printf '\n%10s\n' " This is the CAF-validation test suite"
	@printf '\n%10s\n' " Usage: $(MAKE)  [OPTIONS]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ all:" " tests both - conformance and non-conformance tests"
	@printf '%-20s%-90s\n' " |_ few:" " tests only those listed in the file "test_file" under ./config directory"
	@printf '%-20s%-90s\n' " |_ conformance:" " tests the compiler's feature support (excludes tests that include verification)"
	@printf '%-20s%-90s\n' " |_ non-conformance:" " tests for compile/runtime verifications in accordance with the standard"
	@printf '%-20s%-90s\n' " |_ clean:" " [-results|-tests-history|-compiler-logs|-runtime-logs|-all]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"


all: conformance non-conformance

conformance:
	@cd should_pass; $(MAKE) all; $(MAKE) clean

non-conformance:
	@cd should_fail; $(MAKE) all

few:
	;
















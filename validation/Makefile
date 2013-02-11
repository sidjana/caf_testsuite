
.PHONY: makedef all feature non-conformance confidence few help

default: help


makedef: ./config/CONFIG
	@cd ./config/ ; source config2makedef.sh


feature confidence fault few-tests non-conformance clean clean-output clean-exec clean-history clean-all help all : makedef
	@$(MAKE) -s -f Makefile.in -i ./config/make.def $@	


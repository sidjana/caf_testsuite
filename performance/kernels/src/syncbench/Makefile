SHELL := /bin/bash

TEST = syncbench

COMPILER ?= uhcaf

TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG

include ./$(TEST).def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile $(TEST).x: $(TEST).F90
	@echo -e "\nCompiling ... $(TEST) ..."
	$(COMPILE_CMD) $(TEST).F90 -o $(TEST).x | tee $(TEST).compile.out

execute: $(TEST).x
	@ echo -e "\nExecuting ... $(TEST).x ... with $(NPROCS) images and $(SYNCNITER) iterations "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./$(TEST).x $(SYNCNITER) $(EXEC_OPTIONS)"  | tee $(TEST).exec.out

clean:
	rm -rf *.x *.out *.mod *.compile

SHELL := /bin/bash

TEST = ?

COMPILER ?= uhcaf

TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG

include ./$(TEST).def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile $(TEST).x: $(TEST).F90
	@echo -e "\nCompiling ... $(TEST) ..."
	$(COMPILE_CMD) $(TEST).f90 -o $(TEST).x | tee $(TEST).compile.out

execute: $(TEST).x 
	@ echo -e "\nExecuting ... $(TEST).x ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./$(TEST).x $(EXEC_OPTIONS)"  | tee $(TEST).exec.out
	#@if [ -f $(TEST).exec.out ]; then grep 'clock rate\|elapsed time\|ticks' $(TEST).exec.out  | tee /dev/null ; fi 

clean:
	rm -rf *.x *.out *.mod *.compile

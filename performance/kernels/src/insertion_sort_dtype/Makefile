SHELL := /bin/bash

TEST = insertion_sort_dtype

COMPILER ?= uhcaf

TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG

include ./$(TEST).def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile $(TEST).x: $(TEST).f90
	@echo -e "\nCompiling ... $(TEST) ..."
	$(COMPILE_CMD) $(TEST).f90 -o $(TEST).x | tee $(TEST).compile.out

execute: $(TEST).x
	@ echo -e "\nExecuting ... $(TEST).x ... with $(NPROCS) images "
	@ if [ "$(COMPILER)" == "ifort" ]; then export FOR_COARRAY_NUM_IMAGES=$(NPROCS); fi
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./$(TEST).x $(EXEC_OPTIONS)"  | tee $(TEST).exec.out
	@ $(LAUNCHER) $(ROOT)/../../../../support/kill_orhpan_procs.sh  $(TEST).x

clean:
	rm -rf *.x *.out *.mod *.compile

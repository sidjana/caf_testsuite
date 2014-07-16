SHELL := /bin/bash

TEST = jacobi

COMPILER ?= uhcaf

TEMP_1:=$(shell cd ../../../../config; ./config2makedef.sh; cd -)  # generate make.def from CONFIG

include ./$(TEST).def # user-defined
include ../../../../config/make.def   # auto-generated
include ../../../../config/make-compiler.$(COMPILER).def   # auto-generated

default: compile execute

compile $(TEST).x: $(TEST).f90
	@echo -e "\nCompiling ... $(TEST) ..."
	$(COMPILE_CMD) $(TEST).f90 -o $(TEST).x | tee $(TEST).compile.out

execute: $(TEST).x
	@ echo -e "\nExecuting ... $(TEST).x ... with $(NPROCS) images "
	@ if [ "$(COMPILER)" == "ifort" ]; then export FOR_COARRAY_NUM_IMAGES=$(NPROCS); fi
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./$(TEST).x $(N) $(M) $(P) $(Q) $(EXEC_OPTIONS)"  | tee $(TEST).exec.out
	@ ../../../../support/kill_orphan_procs.sh  $(TEST).x

clean:
	rm -rf *.x *.out *.mod *.compile

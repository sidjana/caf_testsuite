SHELL := /bin/bash

CC=cc

TEST = cafhash

COMPILER ?= uhcaf

TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG

include ./$(TEST).def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile $(TEST).x: $(TEST).F90 hashobj.o
	@echo -e "\nCompiling ... $(TEST) ..."
	$(COMPILE_CMD) -DNHASH=${NHASH} $(TEST).F90 hashobj.o -o $(TEST).x | tee $(TEST).compile.out

hashobj.o: hashobj.c
	$(CC) $(CFLAGS) -DNHASH=${NHASH} -c hashobj.c

execute: $(TEST).x
	@ echo -e "\nExecuting ... $(TEST).x ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./$(TEST).x $(EXEC_OPTIONS)"  | tee $(TEST).exec.out

clean:
	rm -rf *.x *.out *.mod *.compile *.o

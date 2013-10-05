SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./jacobi.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile jacobi.out: jacobi.f90
	@ echo -n "Compiling ... jacobi ... "
	$(COMPILE_CMD) sdjfs jacobi.f90 -o jacobi.out &> jacobi.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: jacobi.out 
	@ echo -n "Executing ... jacobi ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./jacobi.out $(EXEC_OPTIONS)"  &> jacobi.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f jacobi.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' jacobi.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

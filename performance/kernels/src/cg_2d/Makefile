SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./cg_2d.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile cg_2d.out: cg_2d.f90
	@ echo -n "Compiling ... cg_2d ... "
	$(COMPILE_CMD) sdjfs cg_2d.f90 -o cg_2d.out &> cg_2d.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: cg_2d.out 
	@ echo -n "Executing ... cg_2d ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./cg_2d.out $(EXEC_OPTIONS)"  &> cg_2d.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f cg_2d.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' cg_2d.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./mm.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile mm.out: mm.f90
	@ echo -n "Compiling ... mm ... "
	$(COMPILE_CMD) sdjfs mm.f90 -o mm.out &> mm.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: mm.out 
	@ echo -n "Executing ... mm ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./mm.out $(EXEC_OPTIONS)"  &> mm.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f mm.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' mm.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

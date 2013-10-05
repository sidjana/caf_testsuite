SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./buffon_laplace.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile buffon_laplace.out: buffon_laplace.f90
	@ echo -n "Compiling ... buffon_laplace ... "
	$(COMPILE_CMD) sdjfs buffon_laplace.f90 -o buffon_laplace.out &> buffon_laplace.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: buffon_laplace.out 
	@ echo -n "Executing ... buffon_laplace ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./buffon_laplace.out $(EXEC_OPTIONS)"  &> buffon_laplace.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f buffon_laplace.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' buffon_laplace.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

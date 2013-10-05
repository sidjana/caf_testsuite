SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./insertion_sort.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile insertion_sort.out: insertion_sort.f90
	@ echo -n "Compiling ... insertion_sort ... "
	$(COMPILE_CMD) sdjfs insertion_sort.f90 -o insertion_sort.out &> insertion_sort.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: insertion_sort.out 
	@ echo -n "Executing ... insertion_sort ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./insertion_sort.out $(EXEC_OPTIONS)"  &> insertion_sort.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f insertion_sort.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' insertion_sort.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

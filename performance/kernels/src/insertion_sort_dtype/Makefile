SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./insertion_sort_dtype.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile insertion_sort_dtype.out: insertion_sort_dtype.f90
	@ echo -n "Compiling ... insertion_sort_dtype ... "
	$(COMPILE_CMD) sdjfs insertion_sort_dtype.f90 -o insertion_sort_dtype.out &> insertion_sort_dtype.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: insertion_sort_dtype.out 
	@ echo -n "Executing ... insertion_sort_dtype ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./insertion_sort_dtype.out $(EXEC_OPTIONS)"  &> insertion_sort_dtype.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f insertion_sort_dtype.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' insertion_sort_dtype.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

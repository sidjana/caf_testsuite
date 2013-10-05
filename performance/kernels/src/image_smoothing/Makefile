SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../../../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ./image_smoothing.def # user-defined
include ../../../support/make.def   # auto-generated
include ../../../support/make.def-compiler.$(COMPILER)   # auto-generated

default: compile execute

compile image_smoothing.out: image_smoothing.f90
	@ echo -n "Compiling ... image_smoothing ... "
	$(COMPILE_CMD) sdjfs image_smoothing.f90 -o image_smoothing.out &> image_smoothing.compile.out; if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 


execute: image_smoothing.out 
	@ echo -n "Executing ... image_smoothing ... with $(NPROCS) images "
	@ perl ../../../../support/timedexec.pl $(TIMEOUT) "$(LAUNCHER) ./image_smoothing.out $(EXEC_OPTIONS)"  &> image_smoothing.exec.out ;  if [ "$?" == "1" ]; then echo "(Failed)" ; else  echo "(Passed)"; fi 
	@if [ -f image_smoothing.exec.out ]; then grep 'clock rate\|elapsed time\|ticks' image_smoothing.exec.out  | tee /dev/null ; fi 


clean:
	rm -rf *.out *.mod *.compile

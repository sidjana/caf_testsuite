include ../../config/make.def

BIN_PATH:="../bin"

F_TESTS = $(wildcard *.f90)

F_EXES  = $(F_TESTS:.f90=.x)

EXES    = $(F_EXES)

all:    clean $(EXES)

.SUFFIXES: .x

%.x:    %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-20s\t%-80s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   @ source confidence_test.sh "$@" "$^"


clean-log:
	@rm -rf compile_output/*.log exec_output/*.log

clean-exec:
	@rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod

clean-history:
	@rm -rf ./HISTORY/*.log

clean clean-all:  clean-log clean-exec clean-history


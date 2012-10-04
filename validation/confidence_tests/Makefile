include ../config/make.def

FLAGS = $(FFLAGS)
F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(F_EXES)
all:    clean  testmodule.o header  $(EXES)

.SUFFIXES: .x

header:
		@ printf '\n%s\n%s\n' "---------------HPC Tools CAF CONFIDENCE testsuite---------------" \
                    "Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)
	   	@ printf '%-15s\t%-50s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CONFIDENCE"| tee -a $(LOGFILE)


%.x:    %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-15s\t%-50s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   @ source confidence_test.sh "$@" "$^"


testmodule.o:
	@$(FC) $(FLAGS) -c  ../testmodule.f90


clean-log:
	@rm -rf compile_output/*.out exec_output/*.out

clean-exec:
	@rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod

clean-history:
	@rm -rf ./HISTORY/*.log

clean clean-all:  clean-log clean-exec clean-history
	@rm -rf *.o



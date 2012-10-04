include ../config/make.def

LOGFILE:=$(CONF_LOG_PATH)/$(LOG_NAME)


F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(F_EXES)

.PHONY: all header testmodule.o

all:  clean header testmodule.o  $(EXES)
	   @ cp $(LOGFILE) ./HISTORY/
	   @ mv $(LOGFILE) ./latest_results.log


.SUFFIXES: .x


header:
		@ printf '\n%s\n%s\n' "---------------HPC Tools CAF CONFIDENCE testsuite---------------" \
                    "Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)
	   	@ printf '%-15s\t%-50s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CONFIDENCE"| tee -a $(LOGFILE)


%.x:    %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-15s\t%-50s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   @ source confidence_test.sh "$@" "$^" "$(LOGFILE)"


testmodule.o: $(ROOT)/testmodule.f90
	@$(FC) $(FFLAGS) -c  ../testmodule.f90


clean-output:
	@rm -rf compile_output/*.out exec_output/*.out 


clean-exec:
	@rm  -rf  $(BIN_PATH)/*.x    ./*.mod


clean-history:
	@rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	@rm -rf uhcaf.keep ./latest_results.log  testmodule.o

clean:
	@ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"



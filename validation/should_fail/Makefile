include ../config/make.def

DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEATURE_EXEC_PATH)
COMPILE_OUTPUT:=$(FEATURE_COMPILE_PATH)

LOG_NAME:=$(DATE).log
LOGFILE:=$(FEATURE_LOG_PATH)/$(LOG_NAME)


F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(F_EXES) $(F_TESTS)


all:   clean-output header $(EXES) tail
	   @ cp $(LOGFILE) ./HISTORY/
	   @ mv $(LOGFILE) latest_results.log

.SUFFIXES: .x

header:
	   @ printf '\n%s\n%s\n' "---------------HPC Tools CAF NON-CONFORMANCE testsuite---------------"  \
	   				"Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)
	   @ printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  | tee -a $(LOGFILE)

tail:
	@ printf '\n%s%d\n\n' "TOTAL TESTS=" "`echo $(total_cnt)`" | tee -a $(LOGFILE)
#


%.x:    %.f90
	   $(eval COMPILE_STATUS:="UNKNOWN")
	   $(eval EXEC_STATUS:="N/A")
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-20s\t%-80s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   $(eval COMPILE_OUT:=$(shell echo "`$(FC) $(FFLAGS) -o $@ $^ 2>log && echo 2 || echo 3`"))
	   @ cat log
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
		     printf '%-10s\t' "PASS"; \
		 else \
		 	 printf '%-10s\t%s\n' "FAIL" "N/A" ;\
		 fi
	   $(eval EXEC_OUT:=$(shell echo "`perl ../timedexec.pl $(TIMEOUT) $(LAUNCHER)  $@  2>&1 && echo 1 || echo -1`"))
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
	   		 if [ "`echo "$(EXEC_OUT)" | grep "\-1"  `"!="" ]; then \
		         printf '%s\n' "PASS" ;\
			 else \
		 		 printf '%s\n' "FAIL" ;\
			 fi   \
	     fi

test:
	@;


foo:
	 $(eval (shell echo "hi" 123 "bye")


clean-output:
	    @rm -rf compile_output/*.out exec_output/*.out

clean-exec:
	    @rm  -rf  $(BIN_PATH)/*.x   ./*.mod

clean-history:
	    @rm -rf ./HISTORY/*.log

clean-all:  clean-output clean-exec clean-history
	    @rm -rf uhcaf.keep ./*.log

clean:
	@ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"




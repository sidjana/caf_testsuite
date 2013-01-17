include ../config/make.def

DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
LOG_NAME:=$(DATE).log
LOGFILE:=$(FAULT_LOG_PATH)/$(LOG_NAME)


F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(addprefix $(BIN_PATH)/,$(F_EXES) )
total_cnt:=0

.PHONY: all header

all:   clean-output header   $(EXES)
	   @cp $(LOGFILE) ./HISTORY
	   @mv $(LOGFILE) ./latest_results.log


.SUFFIXES: .x

$(EXES): | $(BIN_PATH)



header:
	   @cd ../ ; $(MAKE) -s fault-header | tee -a $(LOGFILE)
	   $(eval total_cnt=0)


$(BIN_PATH)/%.x: %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @printf '%-20s\t%-70s\t' "$(SPEC_IDX)" "$(DESCRIPTION)" | tee -a $(LOGFILE)
	   @source fault_test.sh "$@"  "$^" "$(LOGFILE)"
	   $(eval total_cnt=$(shell echo $(total_cnt)\+1 | bc))


$(BIN_PATH):
	    @mkdir $(BIN_PATH)
		@echo "making dir"

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


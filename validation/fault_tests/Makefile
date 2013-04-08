TEMP_1:=$(shell ../config/config2makedef.sh)  # generate make.def from CONFIG
include ../config/make.def    #auto-generated

DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
LOG_NAME:=$(DATE).log
LOGFILE:=$(FAULT_LOG_PATH)/$(LOG_NAME)


F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(addprefix $(BIN_PATH)/,$(F_EXES) )
total_cnt:=0

.PHONY: all header

all:   clean_output header   $(EXES)
	   @cp $(LOGFILE) ./HISTORY
	   @mv $(LOGFILE) ./latest_results.log


.SUFFIXES: .x

$(EXES): | $(BIN_PATH)



header:
	   @cd ../ ; $(MAKE) -s  fault-header | tee -a $(LOGFILE)
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

clean_output:
	    @rm -rf compile_output/*.out exec_output/*.out


clean_exec:
	    @rm  -rf  $(BIN_PATH)/*.x   ./*.mod


clean_history:
	    @rm -rf ./HISTORY/*.log


clean_all:  clean_output clean_exec clean_history
	    @rm -rf uhcaf.keep ./*.log 


clean:
	@ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean<_output | _exec | _history | all>"


include ../config/make.def

DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
LOG_NAME:=$(DATE).log
LOGFILE:=$(CONF_LOG_PATH)/$(LOG_NAME)


F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(F_EXES)

.PHONY: all header testmodule.o

all:  clean-output header testmodule.o  $(EXES)
	   @ cp $(LOGFILE) ./HISTORY/
	   @ mv $(LOGFILE) ./latest_results.log


.SUFFIXES: .x


header:
	   @cd ../ ; $(MAKE) -s confidence-header | tee -a $(LOGFILE) 


%.x:    %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-15s\t%-70s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   @ source confidence_test.sh "$@" "$^" "$(LOGFILE)"


testmodule.o: ../testmodule.f90
	@$(FC) $(FFLAGS) -c  ../testmodule.f90


clean-output:
	@rm -rf compile_output/*.out exec_output/*.out


clean-exec:
	@rm  -rf  $(BIN_PATH)/*.x    ./*.mod


clean-history:
	@rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	@rm -rf uhcaf.keep ./*.log  testmodule.o

clean:
	@ printf '%s\n%s\n\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"



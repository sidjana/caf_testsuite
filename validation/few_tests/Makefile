SHELL := /bin/bash

TEMP_1:=$(shell ../config/config2makedef.sh)  # generate make.def from CONFIG
include ../config/make.def #auto-generated


DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEW_EXEC_PATH)
COMPILE_OUTPUT:=$(FEW_COMPILE_PATH)


LOG_NAME:=$(DATE).log
LOGFILE:=$(FEW_LOG_PATH)/$(LOG_NAME)
SCRIPTS = crosschecked_feature_test.sh feature_test.sh status_test.sh


all: clean_output clean_exec test_file  testmodule.o description $(SCRIPTS) header
	   @source few_test.sh  "$(LOGFILE)"
	   @cp $(LOGFILE) ./HISTORY/
	   @mv $(LOGFILE) ./latest_results.log
	   @rm $(SCRIPTS) description


#copying scripts from other folders to this one (after modifying the var names).
$(SCRIPTS):
	   @sed 's/CC_FEATURE_/FEW_/g'  $(CC_FEATURE_TEST_PATH)/crosschecked_feature_test.sh > ./crosschecked_feature_test.sh
	   @sed 's/STATUS_/FEW_/g'  $(STATUS_TEST_PATH)/status_test.sh > ./status_test.sh
	   @sed 's/FEATURE_/FEW_/g'  $(FEATURE_TEST_PATH)/feature_test.sh > ./feature_test.sh



header:
	   @printf '\n%s\n\n%s\n\n' "--------------- CAF SPECIFIC testsuite ---------------" \
			                      "Evaluating $(COMPILER)" | tee -a $(LOGFILE)


testmodule.o: $(ROOT)/testmodule.f90
	   @$(FC) $(FFLAGS) -c  ../testmodule.f90


description:
	   @cat $(CC_FEATURE_TEST_PATH)/description >>./description
	   @cat $(STATUS_TEST_PATH)/description >>./description
	   @cat $(FEATURE_TEST_PATH)/description >>./description


clean_output:
	   @rm -rf compile_output/*.out exec_output/*.out


clean_exec:
	   @rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod ./*.o


clean_history:
	   @rm -rf ./HISTORY/*.log


cleanall:  clean_output clean_exec clean_history
	   @rm -rf uhcaf.keep ./*.log ./*.o ./*.f90  $(SCRIPTS) description

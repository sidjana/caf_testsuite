include ../config/make.def


DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEW_EXEC_PATH)
COMPILE_OUTPUT:=$(FEW_COMPILE_PATH)


LOG_NAME:=$(DATE).log
LOGFILE:=$(FEW_LOG_PATH)/$(LOG_NAME)
SCRIPTS = confidence_test.sh feature_test.sh fault_test.sh


all: clean-output test_file  testmodule.o description $(SCRIPTS) header
	   @sh few_test.sh  "$(LOGFILE)"
	   @cp $(LOGFILE) ./HISTORY/
	   @mv $(LOGFILE) ./latest_results.log
	   @rm $(SCRIPTS) description


#copying scripts from other folders to this one (after modifying the var names).
$(SCRIPTS):
	   @sed 's/CONF_/FEW_/g'  $(CONF_TEST_PATH)/confidence_test.sh >  ./confidence_test.sh
	   @sed 's/FAULT_/FEW_/g'  $(FAULT_TEST_PATH)/fault_test.sh > ./fault_test.sh
	   @sed 's/FEATURE_/FEW_/g'  $(FEATURE_TEST_PATH)/feature_test.sh > ./feature_test.sh



header:
	   @printf '\n%s\n\n%s\n\n' "---------------HPC Tools CAF SPECIFIC testsuite---------------" \
			                      "Evaluating $(COMPILER)" | tee -a $(LOGFILE)


testmodule.o: $(ROOT)/testmodule.f90
	   @$(FC) $(FFLAGS) -c  ../testmodule.f90


description:
	   @cat $(CONF_TEST_PATH)/description >>./description
	   @cat $(FAULT_TEST_PATH)/description >>./description
	   @cat $(FEATURE_TEST_PATH)/description >>./description


clean-output:
	   @rm -rf compile_output/*.out exec_output/*.out


clean-exec:
	   @rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod


clean-history:
	   @rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	   @rm -rf uhcaf.keep ./*.log ./*.o ./*.f90  $(SCRIPTS) description


clean:
	   @printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"


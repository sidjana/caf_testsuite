include ../config/make.def


DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEW_EXEC_PATH)
COMPILE_OUTPUT:=$(FEW_COMPILE_PATH)


LOG_NAME:=$(DATE).log
LOGFILE:=$(FEW_LOG_PATH)/$(LOG_NAME)
SCRIPTS = confidence_test.sh conformance_test.sh fault_test.sh


all: clean-output test_file  testmodule.o $(SCRIPTS) header

	#   @sh few_tests.sh
	#   @cp $(LOGFILE) ./HISTORY/
	#   @mv $(LOGFILE) ./latest_results.log


$(SCRIPTS):
	   @sed 's/CONF_/FEW_/g'  $(CONF_LOG_PATH)/confidence_test.sh >  ./confidence_test.sh
	   @sed 's/FAULT_/FEW_/g'  $(FAULT_LOG_PATH)/fault_test.sh > ./fault_test.sh
	   @sed 's/FEATURE_/FEW_/g'  $(FEATURE_LOG_PATH)/conformance_test.sh > ./conformance_test.sh



header:
	   @printf '\n%s\n\n%s\n\n' "---------------HPC Tools CAF SPECIFIC testsuite---------------" \
			                      "Evaluating $(COMPILER)" | tee -a $(LOGFILE)


testmodule.o: $(ROOT)/testmodule.f90
	   @$(FC) $(FFLAGS) -c  ../testmodule.f90


clean-output:
	   @rm -rf compile_output/*.out exec_output/*.out


clean-exec:
	   @rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod


clean-history:
	   @rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	   @rm -rf uhcaf.keep ./*.log ./*.o ./*.f90


clean:
	   @printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"


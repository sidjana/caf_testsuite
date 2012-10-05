include ../config/make.def



DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEATURE_EXEC_PATH)
COMPILE_OUTPUT:=$(FEATURE_COMPILE_PATH)

LOG_NAME:=$(DATE).log
LOGFILE:=$(FEATURE_LOG_PATH)/$(LOG_NAME)

CURRENT:=$(shell pwd)

## @while read -r file; do   \
##  done < test_file 

all: clean-output test_file  testmodule.o header
	   @while read -r file; do   \
	       if [ "$$file" == "CONFORMANCE TESTS" ]; then \
		   	    printf '%s\n' "-----CONFORMANCE TESTS-----"; \
			    type="conformance"; \
				continue; \
    	  elif [ "$$file" == "CONFIDENCE TESTS" ]; then \
		        printf '%s\n' "-----CONFIDENCE TESTS-----"; \
	        	type="confidence"; \
			    continue;\
    	  elif [ "$$file" == "NON-CONFORMANCE TESTS" ]; then \
		        printf '%s\n' "-----NON_CONFORMANCE TESTS-----"; \
	        	type="non-conformance"; \
			    continue;\
    	  elif [ "$$file" == "END OF TESTS" ]; then \
		        printf '%s\n' "-----END OF TESTS-----" ; \
	            continue; \
		  fi ;  \
		  if [ "$$type" == "confidence" ]; then  \
			    file_exec="`echo $$file |sed 's/.f90/.x/' `" ;\
			    cp $(CONF_LOG_PATH)/$$file .  ;\
			    sh confidence_test.sh "$$file_exec" "$$file" "$(LOGFILE)"  ;\
	      elif [ "$$type" == "conformance" ]; then  \
	      	    cd $(FEATURE_LOG_PATH)   ; \
			    make `echo "$$file" |sed 's/.f90/.x/'`  ; \
		        cd $(CURRENT)  ; \
		  fi ; \
		  rm -rf $$file ;  \
	 	done < test_file
	   @cp $(LOGFILE) ./HISTORY/
	   @mv $(LOGFILE) ./latest_results.log


header:
	   @printf '\n%s\n%s\n' "---------------HPC Tools CAF SPECIFIC testsuite---------------" \
			                      "Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)


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


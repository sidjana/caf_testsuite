include ../config/make.def


DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(FEATURE_EXEC_PATH)
COMPILE_OUTPUT:=$(FEATURE_COMPILE_PATH)


LOG_NAME:=$(DATE).log
LOGFILE:=$(FEATURE_LOG_PATH)/$(LOG_NAME)


CURRENT:=$(shell pwd)


all: clean-output test_file  testmodule.o confidence_test.sh header
	   @for file in `cat test_file` ; do   \
	      if [ "$$file" == "CONFORMANCE" ]; then \
		   	    printf '%s\n\n' "-----CONFORMANCE TESTS-----" | tee -a $(LOGFILE) ;\
				printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION"  "COMPILATION" "EXECUTION"  | tee -a $(LOGFILE) ;\
			    type="conformance"; \
				continue; \
    	  elif [ "$$file" == "CONFIDENCE" ]; then \
		        printf '%s\n\n' "-----CONFIDENCE TESTS-----" | tee -a $(LOGFILE) ;\
				printf '%-20s\t%s\t%s\t%s\n\n' "SPEC_IDX" "COMPILATION" "EXECUTION"  "CONFIDENCE"| tee -a $(LOGFILE) ;\
	        	type="confidence"; \
			    continue;\
    	  elif [ "$$file" == "NON-CONFORMANCE" ]; then \
		        printf '%s\n\n' "-----NON_CONFORMANCE TESTS-----" | tee -a $(LOGFILE) ;\
				printf '%-20s\t%s\t%s\n\n' "SPEC_IDX" "COMPILATION" "EXECUTION"  | tee -a $(LOGFILE) ;\
	        	type="non-conformance"; \
			    continue;\
    	  elif [ "$$file" == "END-TESTS" ]; then \
		        printf '%s\n' "-----END OF TESTS-----" | tee -a $(LOGFILE) ;\
	            break; \
		  fi ;  \
		  if [ "$$type" == "confidence" ]; then  \
			    file_exec="`echo $$file | sed "s/.f90/.x/g" `"; \
			    cp $(CONF_LOG_PATH)/$$file  .  ;\
				printf '%-20s\t'  "`echo "$$file"|sed 's/.f90//'| sed 's/*_//'`"   ;\
			    sh confidence_test.sh "$$file_exec" "$$file" "$(LOGFILE)"  ;\
	      elif [ "$$type" == "conformance" ]; then  \
	      	    cd $(FEATURE_LOG_PATH)   ; \
			    make `echo "$$file" |sed 's/.f90/.x/'`  | tee -a $(LOGFILE)  ; \
		        cd $(CURRENT)  ; \
		  fi ; \
		  rm -rf $$file ;  \
	 	done
	   @sed '/Entering directory/d' $(LOGFILE) > $(LOGFILE).tmp
	   @sed '/Leaving directory/d'  $(LOGFILE).tmp > $(LOGFILE)
	   @cp $(LOGFILE) ./HISTORY/
	   @mv $(LOGFILE) ./latest_results.log
	   @rm  $(LOGFILE).tmp


confidence_test.sh:
	   @cp $(CONF_LOG_PATH)/confidence_test.sh .; 
	   @sed 's/CONF_/FEW_/g' confidence_test.sh > confidence_test.sh.1
	   @mv confidence_test.sh.1 confidence_test.sh

header:
	   @printf '\n%s\n\n%s\n\n' "---------------HPC Tools CAF SPECIFIC testsuite---------------" \
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


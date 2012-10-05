include ../config/make.def

LOGFILE:=$(CONF_LOG_PATH)/$(LOG_NAME)


all: test_file  testmodule.o header
	   @while read -r file; do
	       echo "evaluating $file" ; \
	       if [ "$file" == "CONFORMANCE TESTS" ]; then \
			    type="conformance"; \
				continue; \
    	  elif [ "$file" == "CONFIDENCE TESTS" ]; then \
	        	type="confidence"; \
			    continue;\

    elif [ "$file" == "END OF TESTS" ]; then
	        continue
			    fi

    if [ "$type" == "confidence" ]; then
	        echo "evaluating $file in `pwd`"
			        file_exec="`echo $file |sed 's/.f90/.x/' `"
					        cp ../confidence_tests/$file .
							        source confidence_test.sh "$file_exec" "$file" "$LOGFILE"
									        echo "`pwd`"
											    elif [ "$type" == "conformance" ]; then
												        cd $FEATURE_LOG_PATH
														        make `echo "$file" |sed 's/.f90/.x/'`
																        cd $CURRENT
																		        echo "`pwd`"
																				    fi

done < test_file


	   @ source ./test_list.sh  "$(LOGFILE)"
	   @ cp $(LOGFILE) ./HISTORY/
	   @ mv $(LOGFILE) ./latest_results.log


header:
	   @ printf '\n%s\n%s\n' "---------------HPC Tools CAF SPECIFIC testsuite---------------" \
			                      "Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)
	   @ printf '%-15s\t%-50s\t%s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  "CONFIDENCE"| tee -a $(LOGFILE)


testmodule.o: $(ROOT)/testmodule.f90
	   @$(FC) $(FFLAGS) -c  ../testmodule.f90


clean-output:
	   @rm -rf compile_output/*.out exec_output/*.out


clean-exec:
	   @rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod


clean-history:
	   @rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	    @rm -rf uhcaf.keep ./*.log


clean:
	 @ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"




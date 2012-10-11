#!/bin/bash
source ../config/CONFIG
CURRENT=$FEW_LOG_PATH

for file in `cat test_file`
do

    if [ "$file" == "CONFORMANCE-TESTS" -o \
         "$file" == "CONFIDENCE-TESTS"  -o \
         "$file" == "FAULT-TESTS"       -o \
         "$file" == "NON-CONFORMANCE-TESTs"   -o \
         "$file" == "END-TESTS" ]; then

	      if [ "$file" == "CONFORMANCE-TESTS" ]; then
                cd ../; make -s conformance-header 
			    type="conformance"
    	  elif [ "$file" == "CONFIDENCE-TESTS" ]; then
                cd ../; make -s confidence-header
               	type="confidence"
          elif [ "$file" == "FAULT-TESTS"  ]; then
                cd ../; make -s fault-header
                type="fault"
    	  elif [ "$file" == "NON-CONFORMANCE" ]; then
                cd ../; make -s non-conformance-header
	        	type="non-conformance"
    	  elif [ "$file" == "END-TESTS" ]; then
		        printf '%s\n' "-----END OF TESTS-----" | tee -a $LOGFILE
	            break
		  fi

          cd $CURRENT
          continue

    else


		  if [ "$type" == "confidence" ]; then
				printf '%-20s\t'  "`echo "$file"|sed 's/.f90//'| sed 's/*_//'`"
                file_exec="`echo $file | sed "s/.f90/.x/g" `"
			    sh confidence_test_spec.sh "$file_exec" "$file" "$1"
	      elif [ "$type" == "conformance" ]; then
	      	    cd $FEATURE_LOG_PATH
			    make -s `echo "$file" |sed 's/.f90/.x/'`  | tee -a $LOGFILE
		  fi

          cd $CURRENT
    fi

done

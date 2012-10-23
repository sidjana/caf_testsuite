#!/bin/bash
source ../config/CONFIG
CURRENT=$FEW_LOG_PATH

for file in `cat test_file`
do

    if [ -z "$file" ]; then # empty line!
      continue
    fi

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
		        printf '%s\n' "-----END OF TESTS-----" | tee -a $1
                break
		  fi

          cd $CURRENT
          continue

    else

          file_exec="`echo $file | sed "s/.f90/.x/g" `"
		  printf '%-20s\t' "`echo "$file"|sed 's/.f90//'| \
              sed 's/*_//'`" | tee -a $1
          printf '%-70s\t' "`cat description | grep "$file" | \
              sed "s/$file//" | sed 's/^[ ]*//g'`"| tee -a $1

          if [ "$type" == "confidence" ]; then

            if [ -f $CONF_LOG_PATH/$file ]; then
                cp $CONF_LOG_PATH/$file .
			    sh confidence_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi
	      elif [ "$type" == "conformance" ]; then
             if [ -f $FEATURE_LOG_PATH/$file ]; then
                cp $FEATURE_LOG_PATH/$file .
			    sh conformance_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi
          elif [ "$type" == "fault" ]; then
             if [ -f $FAULT_LOG_PATH/$file ]; then
                cp $FAULT_LOG_PATH/$file .
			    sh fault_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi
          elif [ "$type" == "non-conformance" ]; then
                echo "Not supported"
		  fi
    fi
done

#!/bin/bash
source ../config/CONFIG
CURRENT=$FEW_TEST_PATH

for file in `cat test_file`
do

    if [ -z "$file" ]; then # empty line!
      continue
    fi

    if [ "$file" == "FEATURE-TESTS" -o \
         "$file" == "CONFIDENCE-TESTS"  -o \
         "$file" == "FAULT-TESTS"       -o \
         "$file" == "NON-CONFORMANCE-TESTS"   -o \
         "$file" == "END-TESTS" ]; then

	      if [ "$file" == "FEATURE-TESTS" ]; then
                cd ../; make -s feature-header
			    type="feature"
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

            if [ -f $CONF_TEST_PATH/$file ]; then
                cp $CONF_TEST_PATH/$file .
			    sh confidence_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi
	      elif [ "$type" == "feature" ]; then
             if [ -f $FEATURE_TEST_PATH/$file ]; then
                cp $FEATURE_TEST_PATH/$file .
			    sh feature_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi
          elif [ "$type" == "fault" ]; then
             if [ -f $FAULT_TEST_PATH/$file ]; then
                cp $FAULT_TEST_PATH/$file .
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

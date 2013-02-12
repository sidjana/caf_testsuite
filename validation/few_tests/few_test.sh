#!/bin/bash
source ../config/CONFIG
CURRENT=$FEW_TEST_PATH
MAKE_CMD="make -s "

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
	        type="feature"
    	  elif [ "$file" == "CONFIDENCE-TESTS" ]; then
               	type="confidence"
          elif [ "$file" == "FAULT-TESTS"  ]; then
                type="fault"
    	  elif [ "$file" == "NON-CONFORMANCE" ]; then
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

            cd ../; $MAKE_CMD confidence-header; cd ..; 
            if [ -f $CONF_TEST_PATH/$file ]; then
                cp $CONF_TEST_PATH/$file .
		sh confidence_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi

	  elif [ "$type" == "feature" ]; then

            cd ../; $MAKE_CMD feature-header; cd ..;
            if [ -f $FEATURE_TEST_PATH/$file ]; then
                cp $FEATURE_TEST_PATH/$file .
	        sh feature_test.sh "$file_exec" "$file" "$1"
                rm ./$file
            else
                echo "ABSENT"
            fi

          elif [ "$type" == "fault" ]; then

             cd ../; $MAKE_CMD fault-header; cd ..; 
             if [ -f $FAULT_TEST_PATH/$file ]; then
                cp $FAULT_TEST_PATH/$file .
			    sh fault_test.sh "$file_exec" "$file" "$1"
                rm ./$file
             else
                echo "ABSENT"
             fi

          elif [ "$type" == "non-conformance" ]; then

             cd ../; $MAKE_CMD non-conformance-header
             echo "Not supported"

	  fi
    fi
done

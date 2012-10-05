#! /bin/bash
source ../config/CONFIG
LOGFILE="$FEW_LOG_PATH/$LOG_NAME"
CURRENT=`pwd`

while read -r file; do
    echo "evaluating $file"
    if [ "$file" == "CONFORMANCE TESTS" ]; then
        type="conformance"
        continue

    elif [ "$file" == "CONFIDENCE TESTS" ]; then
        type="confidence"
        continue

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



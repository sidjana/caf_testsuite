#!/bin/bash

source ../config/CONFIG
source ../support/killprocs.sh
EXEC_OUTPUT="${FEATURE_EXEC_PATH}"
COMPILE_OUTPUT="${FEATURE_COMPILE_PATH}"

$FC $FFLAGS  -o  $BIN_PATH/$1 $2 &>$COMPILE_OUTPUT/$2.out
if [ "$?" == "0" ]; then
     printf '%s\t\t' "PASS" | tee -a $3
	 perl ../timedexec.pl $TIMEOUT $LAUNCHER  $BIN_PATH/$1 $EXEC_OPTIONS &>$EXEC_OUTPUT/$1.out
     ANS="$?"
	 if [ "$ANS" == "0" ]; then
	 	printf '%s\n' "PASS" | tee -a $3
     elif [ "$ANS" == "4"  ]; then
        printf '%s\n' "TIMEOUT" | tee -a $3
        #killprocs $1
     else
	 	printf '%s\n' "FAIL" | tee -a $3
	 fi
else
     printf '%s\t\t%s\n' "FAIL" "N/A" | tee -a $3
fi


#!/bin/sh

DATE=`date +"%m-%d-%y-%T"` 
ROOT=`pwd`

CC=gcc
LD=gcc
COMPILE_CMD=uhcaf
EXEC_CMD=mpirun
NPOPT=-n

LOG_DIR=$ROOT/log/                # directory for the output of the regression
TESTS_DIR=$ROOT/src/              # directory for the test codes
OUTPUT_DIR=$ROOT/regression_op/   # directory for the output of the compiler/execution 
BIN_DIR=$ROOT/bin/                # directory for the binaries

COMPILE_TESTS="0"
EXECUTE_TESTS="0"
BOTH="0"
TIMEOUT=120

if [ $# == 1 ]; then
  if [ "$1" == "compile" ]; then
    COMPILE_TESTS="1"
  elif [ "$1" == "execute" ]; then
    EXECUTE_TESTS="1"
  elif [ "$1" == "complete" ]; then
    BOTH="1"
  else
    echo "USAGE:  compile | execute | complete"
  fi
else
  echo "USAGE: compile | execute | complete"
fi

# organize past regression results
rm -rf $OUTPUT_DIR/latest_*
mkdir -p $OUTPUT_DIR/latest_compile > /dev/null
mkdir -p $OUTPUT_DIR/latest_execute > /dev/null

sh setenv.sh

import $NITER
import $TIMER_ARCH

cd $TESTS_DIR

$CC -c rtc.c -o rtc.o -D$TIMER_ARCH 

PASSED_COMPILE_COUNT=0
FAILED_COMPILE_COUNT=0
COMPILE_STATUS="UNKNOWN"
EXEC_STATUS="UNKNOWN"
EXEC_OUT="0"

echo " Testing the Microbenchmarks..."
echo "<NAME>         <NPROCS>           <COMPILATION>          <EXECUTION>" 

for file in `ls *.f90`; do
  #for class in S W; do
    for NP  in  1 2 4; do
       type=`echo $file | awk -F"/" '{print $NF}'`
       opfile=$type.$NP
       logfile=$DATE.log
       if [ "$COMPILE_TESTS"=="1" -o "$BOTH"=="1" ]; then
        COMPILE_OUT=`$COMPILE_CMD  $type rtc.o -o $BIN_DIR/$opfile -ftpp -DNITER=$NITER >>$OUTPUT_DIR/latest_compile/$opfile.compile 2>&1 && echo 1 || echo -1`
        if [ "$COMPILE_OUT" -eq "1" ]; then
          COMPILE_STATUS="PASS"
          PASSED_COMPILE_COUNT=$(($PASSED_COMPILE_COUNT+1))
        else
          COMPILE_STATUS="FAIL"
          FAILED_COMPILE_COUNT=$(($FAILED_COMPILE_COUNT+1))
        fi
       fi
       if [ "$EXECUTE_TESTS" -eq "1" -o "$BOTH" -eq "1" ]; then           #execution enabled
             if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed
                EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "$EXEC_CMD -np $NP $BIN_DIR/$opfile" >\dev\null && echo 1||echo -1`
                echo "EXEC=$EXEC_OUT"
                if [ "$EXEC_OUT" == "-1" ]; then                         #runtime error
                    EXEC_STATUS="RUNTIME ERROR"
                else                                                      #execution completed cleanly
                    echo $EXEC_OUT>>$OUTPUT_DIR/latest_execute/$opfile.exec
                    VERIFICATION="SUCCESSFUL" 
                    if [ "$VERIFICATION" == "SUCCESSFUL" ]; then          #output correct
                       EXEC_STATUS="SUCCESSFUL" 
                    else #output incorrect
                       EXEC_STATUS="UNSUCCESSFUL"
                    fi
                fi
            else
                EXEC_STATUS="NO BINARY"                                   #compilation passed
            fi
       fi
       echo "$type         $NP       $COMPILE_STATUS          $EXEC_STATUS" >> $LOG_DIR/$logfile 
       echo "$type         $NP       $COMPILE_STATUS          $EXEC_STATUS"
    done
  #done
done
echo "______________________________STATISTICS__________________________________" >>$LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COMPILE_COUNT TOTAL FAILED = $FAILED_COMPILE_COUNT" >>$LOG_DIR/$logfile
echo "Log file : $LOG_DIR/$logfile"
mv  $OUTPUT_DIR/latest_compile $OUTPUT_DIR/history/compile_$DATE
mv  $OUTPUT_DIR/latest_execute $OUTPUT_DIR/history/execute_$DATE

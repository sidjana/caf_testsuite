#!/bin/sh

DATE=`date +"%m-%d-%y-%T"` 
ROOT=`pwd`

LOG_DIR=$ROOT/log/                # directory for the output of the regression
TESTS_DIR=$ROOT/                  # directory for the test codes
OUTPUT_DIR=$ROOT/regression_op/   # directory for the output of the compiler/execution 
BIN_DIR=$ROOT/bin/

COMPILE_TESTS=0
EXECUTE_TESTS=0
BOTH=0

if [ $# == 1 ]; then
  if [ "$1" == "compile" ]; then
    COMPILE_TESTS=1
  elif [ "$1" == "execute" ]; then
    EXECUTE_TESTS=1
  elif [ "$1" == "complete" ]; then
    BOTH=1
  else
    echo "USAGE:  compile | execute | complete"
  fi
else
  echo "USAGE: compile | execute | complete"
fi

echo "comp=$COMPILE_TESTS, exec=$EXECUTE_TESTS, both=$BOTH"
TIMEOUT=120

rm -rf $OUTPUT_DIR/latest_*
mkdir -p $OUTPUT_DIR/latest_compile > /dev/null
mkdir -p $OUTPUT_DIR/latest_execute > /dev/null

cd $TESTS_DIR

PASSED_COMPILE_COUNT=0
FAILED_COMPILE_COUNT=0
COMPILE_STATUS="UNKNOWN"
EXEC_STATUS="UNKNOWN"
EXEC_OUT="0"
COMPILE_OUT="0"

echo " Testing the NAS Parallel Benchmarks ..."
echo "<TYPE> <NPROCS> <CLASS> <COMPILATION> <EXECUTION>" 

for type in ep cg; do
#  for class in S W A B C D; do
  for class in S W; do
    for NP  in  1 2 4; do
       opfile=$type.$class.$NP
       logfile=$DATE.log
       if [ "$COMPILE_TESTS" -eq 1 -o "$BOTH" -eq 1 ]; then
        COMPILE_OUT=`gmake $type NPROCS=$NP CLASS=$class>>$OUTPUT_DIR/latest_compile/$opfile.compile 2>&1 && echo 1 || echo -1`
        if [ "$COMPILE_OUT"=="1" ]; then
          COMPILE_STATUS="PASS"
          PASSED_COMPILE_COUNT=$(($PASSED_COMPILE_COUNT+1))
        else
          COMPILE_STATUS="FAIL"
          FAILED_COMPILE_COUNT=$(($FAILED_COMPILE_COUNT+1))
        fi
       fi
       if [ $EXECUTE_TESTS -eq 1 -o $BOTH -eq 1 ]; then                 #execution enabled

             if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed

                EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "mpirun -n $NP $BIN_DIR/$opfile" 2>&1>>$OUTPUT_DIR/latest_execute/$opfile.exec || echo -1`
                if [ "$EXEC_OUT" -eq -1 ]; then                          #runtime error
                    EXEC_STATUS="RUNTIME ERROR"
                else                                                      #execution completed cleanly
                    VERIFICATION=` cat $OUTPUT_DIR/latest_execute/$opfile.exec | grep SUCCESS | awk '{print $3}'`
                    echo $EXEC_OUT>>$OUTPUT_DIR/latest_execute/$opfile.exec
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
       echo "$type         $NP       $class     $COMPILE_STATUS          $EXEC_STATUS" >> $LOG_DIR/$logfile 
       echo "$type         $NP       $class     $COMPILE_STATUS          $EXEC_STATUS"
    done
  done
done
echo "______________________________STATISTICS__________________________________" >>$LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COMPILE_COUNT TOTAL FAILED = $FAILED_COMPILE_COUNT" >>$LOG_DIR/$logfile
echo "Log file : $LOG_DIR/$logfile"
cp -r  $OUTPUT_DIR/latest_compile $OUTPUT_DIR/history/compile_$DATE
cp -r  $OUTPUT_DIR/latest_execute $OUTPUT_DIR/history/execute_$DATE

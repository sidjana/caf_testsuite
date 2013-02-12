#!/bin/bash

source ../support/CONFIG

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

# delete past regression results and make folders if needed
rm -rf $COMP_OUT_DIR $EXEC_OUT_DIR $BIN_DIR
mkdir -p $COMP_OUT_DIR $EXEC_OUT_DIR  $HISTORY_OUT_DIR $BIN_DIR $LOG_DIR

cd $TESTS_DIR

printf '%20s %5s %20s %20s\n' "<NAME>" "<NPROCS>" "<COMPILATION>" "<EXECUTION>" 

for file in `ls *.f90`; do
    for NP  in  2 4 8
    do
       type=`echo $file | awk -F"/" '{print $NF}'`
       opfile=$type.$NP
       logfile=$DATE.log
       printf '%20s %5s ' "$type" "$NP" 
       if [ "$COMPILE_TESTS"=="1" -o "$BOTH"=="1" ]; then
        COMPILE_OUT=`$COMPILE_CMD  $type -o $BIN_DIR/$opfile -ftpp -DNITER=$NITER >>$COMP_OUT_DIR/$opfile.compile 2>&1 && echo 1 || echo -1`
        if [ "$COMPILE_OUT" -eq "1" ]; then
          COMPILE_STATUS="PASS"
        else
          COMPILE_STATUS="FAIL"
        fi
       fi
       printf '%20s ' "$COMPILE_STATUS"
       if [ "$EXECUTE_TESTS" -eq "1" -o "$BOTH" -eq "1" ]; then           #execution enabled
             if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed
                EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "$EXEC_CMD -np $NP $BIN_DIR/$opfile "  &> $EXEC_OUT_DIR/$opfile.exec  && echo 1||echo -1`

                if [ "$EXEC_OUT" == "-1" ]; then                         #runtime error
                    EXEC_STATUS="RUNTIME ERROR"
          	    FAILED_COUNT=$(($FAILED_COUNT+1))
                else                                                      #execution completed cleanly
                    echo $EXEC_OUT>>$OUTPUT_DIR/latest_execute/$opfile.exec
                    EXEC_STATUS="PASS" 
          	    PASSED_COUNT=$(($PASSED_COUNT+1))
                fi
            else
                EXEC_STATUS="NO BINARY"                                   #compilation passed
            fi
       fi
       printf '%20s\n' "$EXEC_STATUS" | tee -a $LOG_DIR/$logfile 
    done
done

echo "______________________________EXECUTION STATISTICS (not compilation)__________________________" | tee -a $LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COUNT TOTAL FAILED = $FAILED_COUNT"  | tee -a $LOG_DIR/$logfile
echo "Results of this performance run can be found in: $LOG_DIR/$logfile"

# backing up results to HISTORY folder
cp -r  $COMP_OUT_DIR  $HISTORY_OUT_DIR/compile_$DATE
cp -r  $EXEC_OUT_DIR  $HISTORY_OUT_DIR/execute_$DATE

cd ..


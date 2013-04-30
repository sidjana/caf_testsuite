#!/bin/sh

if [ -f ../support/CONFIG ]; then
  source ../support/CONFIG
else
  echo "CONFIG file missing. Please ensure that CONFIG file is present under $ROOT/../support"
fi

if [ "$1" == "cleanall" ]; then
    rm -rf $LOG_DIR $BIN_DIR
    exit 0
fi

if [ $# == 2 ]; then
  if [ "$1" == "compile" ]; then
    COMPILE_TESTS="1"
    compiler=$2
  elif [ "$1" == "execute" ]; then
    EXECUTE_TESTS="1"
    compiler=$2
  elif [ "$1" == "complete" ]; then
    BOTH="1"
    compiler=$2
  else
  echo "USAGE: test_microbenchmarks.sh [mode [compiler] ] where "
  echo "           mode     = compile|execute|complete"
  echo "           compiler = uhcaf|ifort|g95"
  echo "The results of all the microbenchmarks are stored in a plottable format in $EXEC_OUT_DIR"
    exit 1
  fi
else
  echo "USAGE: test_microbenchmarks.sh [mode] [compiler] where "
  echo "           mode     = compile|execute|complete"
  echo "           compiler = uhcaf|ifort|g95"
  echo -e "Please ensure:\n The test_suite specific parameters are set in ${BENCH_PATH}/../support/CONFIG \n The compiler specific parameters in ${BENCH_PATH}/../support/CONFIG-compiler.<compiler> \n"
  exit 1
fi

if [ -f ../support/CONFIG-compiler.${compiler} ]; then
continue
else
  echo "CONFIG-compiler.${compiler} file missing. Please ensure that CONFIG file is present under $ROOT/../support"
  exit 1
fi

# delete past regression results and make folders if needed
rm -rf $COMP_OUT_DIR $EXEC_OUT_DIR
mkdir -p $COMP_OUT_DIR $EXEC_OUT_DIR  $HISTORY_OUT_DIR $BIN_DIR $LOG_DIR

cd $TESTS_DIR

$CC -c rtc.c -o $BIN_DIR/rtc.o -D$TIMER_ARCH

printf '%20s %5s %20s %20s\n' "<NAME>" "<NPROCS>" "<COMPILATION>" "<EXECUTION>"  | tee -a $LOG_DIR/$logfile

echo "The results of all the microbenchmarks are stored in plottable format in $EXEC_OUT_DIR"

for file in `ls *.f90`; do
       NP=2
       NPROCS=$NP
       source ${BENCH_PATH}/../support/CONFIG-compiler.${compiler}
       type=`echo $file | awk -F"/" '{print $NF}'`
       opfile=$type.$NP
       logfile=$DATE.log
       printf '%20s %5s ' "$type" "$NP"  | tee -a $LOG_DIR/$logfile
       if [ "$COMPILE_TESTS" == "1" -o "$BOTH"=="1" ]; then
        COMPILE_OUT=`$COMPILE_CMD  $type $BIN_DIR/rtc.o -o $BIN_DIR/$opfile >>$COMP_OUT_DIR/$opfile.compile 2>&1 && echo 1 || echo -1`
        if [ "$COMPILE_OUT" -eq "1" ]; then
          COMPILE_STATUS="PASS"
        else
          COMPILE_STATUS="FAIL"
        fi
       fi
       printf '%20s ' "$COMPILE_STATUS"  | tee -a $LOG_DIR/$logfile
       if [ "$EXECUTE_TESTS" -eq "1" -o "$BOTH" -eq "1" ]; then           #execution enabled
             if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed
                EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "$LAUNCHER $BIN_DIR/$opfile $EXEC_OPTIONS  "  &> $EXEC_OUT_DIR/$opfile.exec  && echo 1||echo -1`

                if [ "$EXEC_OUT" == "-1" ]; then                         #runtime error
                    EXEC_STATUS="RUNTIME ERROR"
          	    FAILED_COUNT=$(($FAILED_COUNT+1))
                else                                                      #execution completed cleanly
                    EXEC_STATUS="PASS"
          	    PASSED_COUNT=$(($PASSED_COUNT+1))
                fi
            else
                EXEC_STATUS="NO BINARY"                                   #compilation passed
            fi
       fi
       printf '%20s\n' "$EXEC_STATUS" | tee -a $LOG_DIR/$logfile
done

echo "______________________________EXECUTION STATISTICS (not compilation)__________________________" | tee -a $LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COUNT TOTAL FAILED = $FAILED_COUNT"  | tee -a $LOG_DIR/$logfile
echo "Results of this performance run can be found in: $LOG_DIR/$logfile"

# backing up results to HISTORY folder
cp -r  $COMP_OUT_DIR  $HISTORY_OUT_DIR/compile_$DATE
cp -r  $EXEC_OUT_DIR  $HISTORY_OUT_DIR/execute_$DATE

cd ..;


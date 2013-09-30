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
  echo "USAGE: test_npb.sh [mode [compiler] ] where "
  echo "           mode     = compile|execute|complete"
  echo "           compiler = uhcaf|ifort|g95"
    exit 1
  fi
else
  echo "USAGE: test_npb.sh [mode] [compiler] where "
  echo "           mode     = compile|execute|complete"
  echo "           compiler = uhcaf|ifort|g95"
  echo -e "Please ensure:\n The test_suite specific parameters are set in ${BENCH_PATH}/../support/CONFIG \n The compiler specific parameters in ${BENCH_PATH}/../support/CONFIG-compiler.<compiler> \n"
  exit 1
fi

if [ -f ./config/make.def.${compiler} ]; then
  cp ./config/make.def.$compiler ./config/make.def
else
  echo "./config/make.def.${compiler} file missing. Please ensure that this file is present."
  exit 1
fi

# delete past regression results and make folders if needed
rm -rf $COMP_OUT_DIR $EXEC_OUT_DIR $BIN_DIR
mkdir -p $COMP_OUT_DIR $EXEC_OUT_DIR  $HISTORY_OUT_DIR $BIN_DIR $LOG_DIR

printf '%8s %8s %8s %15s %15s %10s %25s \n' "<NAME>" "<CLASS>" "<NPROCS>" "<COMPILATION>" "<EXECUTION>" "<RESULT>" "<TIME(secs)>" | tee -a $LOG_DIR/$logfile

for BM in ep cg sp bt
do
	for CLASS in S W A B C
	do
  		  if [ "$BM" == "ep" -o "$BM" == "cg" ]; then
  		       NPROCS_LST="1 2 4 8 16";
  		  else
  		       NPROCS_LST="1 4 9 16"
  		  fi

  		  for NP in  $NPROCS_LST
  		  do
		  	NPROCS=$NP
			source ${BENCH_PATH}/../support/CONFIG-compiler.$compiler
			cp ./config/make.def.$compiler ./config/make.def
  		     	opfile=$BM.$CLASS.$NP
			printf '%8s %8s %8s ' "$BM" "$CLASS" "$NP"  | tee -a $LOG_DIR/$logfile
  		     	if [ "$COMPILE_TESTS"=="1" -o "$BOTH"=="1" ]; then

			 	make clean &>/dev/null
  		     	 	COMPILE_OUT=`make $BM NPROCS=$NP CLASS=$CLASS COMPILER=$compiler >>$COMP_OUT_DIR/$opfile.compile 2>&1 && echo 1 || echo -1`
  		     	 	if [ "$COMPILE_OUT" == "1" ]; then
  		     	 		 COMPILE_STATUS="PASS"
  		     	 	else
  		     	 	  	 COMPILE_STATUS="FAIL"
  		     	 	fi
  		     	fi
			printf '%15s ' "$COMPILE_STATUS"  | tee -a $LOG_DIR/$logfile
  		     	if [ "$EXECUTE_TESTS" -eq "1" -o "$BOTH" -eq "1" ]; then           #execution enabled
			      VERIFICATION="UNKNOWN"
			      TIME="--"
  		     	      if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed

  		     	         EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "$LAUNCHER $BIN_DIR/$opfile $EXEC_OPTIONS " &> $EXEC_OUT_DIR/$opfile.exec && echo 1||echo -1`
  		     	         if [ "$EXEC_OUT" == "-1" ]; then                         #runtime error
  		     	             EXEC_STATUS="RUNTIME ERROR"
				     FAILED_COUNT=$(($FAILED_COUNT+1))
  		     	         else                                                      #execution completed cleanly
				     EXEC_STATUS="PASS"
				     PASSED_COUNT=$(($PASSED_COUNT+1))
				     VERIFICATION=`grep "Verification"  $EXEC_OUT_DIR/$opfile.exec | grep -oh "\w*SUCCESSFUL"  `
				     TIME=`grep "seconds"  $EXEC_OUT_DIR/$opfile.exec | sed 's/.*=//g' |sed 's/\s\+//g' `
  		     	         fi
  		     	     else
  		     	         EXEC_STATUS="NO BINARY"                                   #compilation failed
  		     	     fi
  		     	fi
  		     	printf '%15s %18s %15s\n' "${EXEC_STATUS}" "${VERIFICATION}" "${TIME}" | tee -a $LOG_DIR/$logfile
  		  done
	done
done

echo "______________________________EXECUTION STATISTICS (not compilation)__________________________" | tee -a $LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COUNT TOTAL FAILED = $FAILED_COUNT"  | tee -a $LOG_DIR/$logfile
echo "Results of this performance run can be found in: $LOG_DIR/$logfile"

# backing up results to HISTORY folder
cp -r  $COMP_OUT_DIR  $HISTORY_OUT_DIR/compile_$DATE
cp -r  $EXEC_OUT_DIR  $HISTORY_OUT_DIR/execute_$DATE
rm -rf ./config/make.def

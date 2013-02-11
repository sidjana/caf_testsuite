#!/bin/sh

source ../CONFIG

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
rm -rf $COMP_OUT_DIR $EXEC_OUT_DIR
echo "mkdir -p $COMP_OUT_DIR $EXEC_OUT_DIR  $HISTORY_OUT_DIR $BIN_DIR $LOG_DIR"
mkdir -p $COMP_OUT_DIR $EXEC_OUT_DIR  $HISTORY_OUT_DIR $BIN_DIR $LOG_DIR

echo "Testing the NPB"
printf '%8s %8s %8s %15s %15s %10s \n' "<NAME>" "<CLASS>" "<NPROCS>" "<COMPILATION>" "<EXECUTION>" "<RESULT>" 


for BM in ep sp bt 
do
	for CLASS in S A B C
	do
  		  if [ "$BM" == "ep" -o "$BM" == "cg" ]; then
  		       NPROCS="1 2 4 8 16";
  		  else
  		       NPROCS="1 4 9 16"    
  		  fi

  		  for NP in  $NPROCS
  		  do
  		     	opfile=$BM.$CLASS.$NP
			printf '%6s %6s %6s ' "$BM" "$NP" "$CLASS" 
  		     	if [ "$COMPILE_TESTS"=="1" -o "$BOTH"=="1" ]; then
			
			 	# adding make.def support for intel
			 	sed "s/-coarray-num-images=.* /-coarray-num-images=$NPROCS /g" ./config/make.def > ./config/make.def.intel
			 	cp ./config/make.def.intel ./config/make.def

			 	make clean &>/dev/null
  		     	 	COMPILE_OUT=`make $BM NPROCS=$NP CLASS=$CLASS >>$COMP_OUT_DIR/$opfile.compile 2>&1 && echo 1 || echo -1`
  		     	 	if [ "$COMPILE_OUT" == "1" ]; then
  		     	 		 COMPILE_STATUS="PASS"
  		     	 	 	 PASSED_COMPILE_COUNT=$(($PASSED_COMPILE_COUNT+1))
  		     	 	else
  		     	 	  	 COMPILE_STATUS="FAIL"
  		     	 	  	 FAILED_COMPILE_COUNT=$(($FAILED_COMPILE_COUNT+1))
  		     	 	fi
  		     	fi
			printf '%15s ' "$COMPILE_STATUS"
  		     	if [ "$EXECUTE_TESTS" -eq "1" -o "$BOTH" -eq "1" ]; then           #execution enabled
			      VERIFICATION="UNKNOWN"
  		     	      if [ -f  $BIN_DIR/$opfile ]; then  #compilation passed

  		     	         EXEC_OUT=` perl $ROOT/../../support/timedexec.pl $TIMEOUT "$EXEC_CMD -np $NP $BIN_DIR/$opfile " &> $EXEC_OUT_DIR/$opfile.exec && echo 1||echo -1`
  		     	         if [ "$EXEC_OUT" == "-1" ]; then                         #runtime error
  		     	             EXEC_STATUS="RUNTIME ERROR"
  		     	         else                                                      #execution completed cleanly
				     EXEC_STATUS="PASS"
				     VERIFICATION=`grep -oh "\w*SUCCESSFUL"  $EXEC_OUT_DIR/$opfile.exec`
  		     	         fi
  		     	     else
  		     	         EXEC_STATUS="NO BINARY"                                   #compilation failed
  		     	     fi
  		     	fi
  		     	printf '%15s %18s\n' "$EXEC_STATUS" "$VERIFICATION" | tee -a $LOG_DIR/$logfile 
  		  done
	done
done

echo "______________________________STATISTICS__________________________________" | tee -a $LOG_DIR/$logfile
echo "TOTAL PASSED = $PASSED_COMPILE_COUNT TOTAL FAILED = $FAILED_COMPILE_COUNT"  | tee -a $LOG_DIR/$logfile
echo "Results of this performance run can be found in: $LOG_DIR/$logfile"

# backing up results to HISTORY folder
cp -r  $COMP_OUT_DIR  $HISTORY_OUT_DIR/compile_$DATE
cp -r  $EXEC_OUT_DIR  $HISTORY_OUT_DIR/execute_$DATE

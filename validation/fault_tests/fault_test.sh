#!/bin/bash

source ../config/CONFIG
EXEC_OUTPUT="${FAULT_EXEC_PATH}"
COMPILE_OUTPUT="${FAULT_COMPILE_PATH}"

exec_out="0"

$FC $FFLAGS -o $1  $2 &>$COMPILE_OUTPUT/$2.out
if [ "$?" == "0" ]; then
		printf '%-15s\t' "PASS"  | tee -a $3
		for i in {1..$NITER}
		do
			perl ../timedexec.pl $TIMEOUT $LAUNCHER  $1 $EXEC_OPTIONS &> $EXEC_OUTPUT/$2.out
			if [ "$?" != "0" ]; then
				exec_out="1"
				break
	   		fi
  		done
		if [ "$exec_out" != "0" ]; then
			printf '%-15s\n' "FAIL"  | tee -a $3
		else
		    printf '%-15s\n' "PASS"  | tee -a $3
		fi
else
		printf '%-15s\t%-15s\n' "FAIL" "N/A"  | tee -a $3
fi



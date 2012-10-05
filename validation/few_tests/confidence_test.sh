source ../config/CONFIG

EXEC_OUTPUT="${FEW_EXEC_PATH}"
COMPILE_OUTPUT="${FEW_COMPILE_PATH}"

echo "$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 2>$COMPILE_OUTPUT/$2.out"
$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 2>$COMPILE_OUTPUT/$2.out
if [ "$?" == "0" ]; then
   printf '%-15s\t' "PASS"  | tee -a $3
   perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>$EXEC_OUTPUT/$1.out
   if [ "$?" == "4" ]; then
       printf '%-15s\t' "PASS"  | tee -a $3
       $FC $FFLAGS_CROSS  -o  $BIN_PATH/$1 testmodule.o $2  2>/dev/null
       perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>/dev/null
       if [ "$?" == "6"  ]; then
         printf '%-10s\n' "PASS_HIGH"  | tee -a $3
       else
         printf '%-10s\n' "PASS_LOW"  | tee -a $3
       fi
   else
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $3
   fi
else
   printf '%-15s\t%-15s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $3
fi


#!/bin/bash

source ../config/CONFIG
EXEC_OUTPUT="${CONF_EXEC_PATH}"
COMPILE_OUTPUT="${CONF_COMPILE_PATH}"


$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 &>$COMPILE_OUTPUT/$2.out

if [ "$?" == "0" ]; then
   # feature test passed compilation
   printf '%-15s\t' "PASS"  | tee -a $3

   #run the feature test
   perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" &>$EXEC_OUTPUT/$1.out

  # check if the feature test passed execution
   if [ "$?" == "4" -o "$?" == "0" ]; then
       # feature test passed execution
       printf '%-15s\t' "PASS"  | tee -a $3

       # compile the cross test
       $FC $FFLAGS_CROSS  -o  $BIN_PATH/$1 testmodule.o $2 &>/dev/null

       # run the cross test
       perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" &>/dev/null

       # check if the cross test passes
       printf '%-10s\n' "$?%" | tee -a $3

       if [ "$?" == "6"  ]; then
         # feature test passed with high confidence
         printf '%-10s\n' "PASS_HIGH"  | tee -a $3

       else
         # feature test passed with low confidence
         printf '%-10s\n' "PASS_LOW"  | tee -a $3

       fi

   else
       # feature test failed execution
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $3

   fi

else
   # feature test failed compilation
   printf '%-15s\t%-15s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $3

fi


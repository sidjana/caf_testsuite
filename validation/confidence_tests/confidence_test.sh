#!/bin/bash

source ../../config/CONFIG

#compile feature  test
#echo "$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 2>$COMPILE_OUTPUT/$2.log"
COMPILE_OUT=`$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 2>$COMPILE_OUTPUT/$2.log`

if [ "$?" == "0" ]; then
   # feature test passed compilation
   printf '%s\t' "PASS"

   #run the feature test
   #echo "perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>$EXEC_OUTPUT/$1.log"
   EXEC_OUT=`perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>$EXEC_OUTPUT/$1.log`

  # check if the feature test passed execution
   if [ "$?" == "4" ]; then
       # feature test passed execution
       printf '%s\t' "PASS"

       # compile the cross test
       #echo "$FC $FFLAGS_CROSS  -o $BIN_PATH/$1 testmodule.o $2  2>/dev/null"
       COMPILE_CROSS_OUT=`$FC $FFLAGS_CROSS  -o  $BIN_PATH/$1 testmodule.o $2  2>/dev/null`

       # run the cross test
       #echo "perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>/dev/null"
       EXEC_CROSS_OUT=`perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>/dev/null`

       # check if the cross test passes
       if [ "$?" == "6"  ]; then
         # feature test passed with high confidence
         printf '%s\n' "PASS_HIGH"

       else
         # feature test passed with low confidence
         printf '%s\n' "PASS_LOW"

       fi

   else
       # feature test failed execution
       printf '%s\t%s\n' "FAIL" "--"

   fi

else
   # feature test failed compilation
   printf '%-10s\t%s\t%s\n' "FAIL" "N/A" "--"

fi


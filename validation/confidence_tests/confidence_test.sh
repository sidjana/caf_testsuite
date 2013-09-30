#!/bin/bash

config_file="../config/CONFIG"
if [ ! -f $config_file ]; then
    config_file="../config/CONFIG.sample"
fi
source $config_file
EXEC_OUTPUT="${CONF_EXEC_PATH}"
COMPILE_OUTPUT="${CONF_COMPILE_PATH}"

$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 &>$COMPILE_OUTPUT/$2.out
ANS="$?"
if [ "$ANS" == "0" ]; then
   # feature test passed compilation
   printf '%-15s\t' "PASS"  | tee -a $3

   #run the feature test
   perl ../support/timedexec.pl $TIMEOUT $LAUNCHER $BIN_PATH/$1 $EXEC_OPTIONS &>$EXEC_OUTPUT/$2.out
  # check if the feature test passed execution
   if [ "$?" == "0" ]; then
       # feature test passed execution
       printf '%-15s\t' "PASS"  | tee -a $3

       # compile the cross test
       $FC $FFLAGS_CROSS  -o  $BIN_PATH/$1.cross testmodule.o $2 &>/dev/null

       # run the cross test
       #rm -rf conf.temp
       perl ../support/timedexec.pl $TIMEOUT $LAUNCHER $BIN_PATH/$1.cross $EXEC_OPTIONS &>./tmp
       RETURN="$?"

       if [ "$FC" == "g95" ]; then 
		echo "`sed -n 's/.*(//;s/).*//p' ./tmp`"%
       else
       		echo `cat conf.temp`
		#rm -rf conf.temp
       fi
#	rm ./tmp

  elif [ "$ANS" == "4" ]; then
       # feature test timed out
       printf '%-15s\t%-10s\n' "TIMEOUT" "--"  | tee -a $3
  else
       # feature test failed execution
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $3
  fi

else
   # feature test failed compilation
   printf '%-15s\t%-15s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $3

fi


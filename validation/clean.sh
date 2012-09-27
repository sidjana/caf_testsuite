if [ "$1" == "messages" ]; then
  rm -rf ./should_pass/compile_output/*.compile.out ./should_pass/exec_output/*.exec.out ./should_fail/compile_output/*.compile.out ./should_fail/exec_output/*.exec.out

elif [ "$1" == "logs"  ]; then
  rm -rf ./results/*.log ./results/HISTORY/*.log
  rm -rf ./results/*.tar

elif [ "$1" == "bin" ]; then
  rm -rf  ./executables/*.x

elif [ "$1" == "all" ]; then
  sh ./clean.sh messages
  sh ./clean.sh logs
  sh ./clean.sh bin

fi


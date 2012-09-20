if [ "$1" == "tests_output" ]; then
  rm -rf ./should_pass/compile_output/*compile.out ./should_pass/exec_output/*.exec.out ./should_fail/compile_output/*.compile.out ./should_fail/exec_output/*.exec.out  ./executables/*.x
elif [ "$1" == "logs"  ]; then
  rm -rf ./results/*.log
  rm -rf *.tar 
fi

if [ "$1" == "all" ]; then
  rm -rf ./should_pass/compile_output/*compile.out ./should_pass/exec_output/*.exec.out ./should_fail/compile_output/*.compile.out ./should_fail/exec_output/*.exec.out  ./executables/*.x
  rm -rf ./results/*.log *.tar
fi

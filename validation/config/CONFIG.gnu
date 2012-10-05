#GNU CAF Compiler

# path vals
ROOT="/home/sidjana/caf_testsuite/validation"
BIN_PATH="${ROOT}/bin"

#for ALL TESTS
COMPILER="GNU"
FC="mpif90"
NPROCS="4"
NITER="2"
SLEEP="1"
FFLAGS="-fcoarray=lib  -lcaf_mpi  -fpp -DNPROCS=${NPROCS} -DNITER=${NITER} -DSLEEP=${SLEEP}"
LAUNCHER="mpiexec -n ${NPROCS}"
TIMEOUT="60"




#for CONFIDENCE TESTS
FFLAGS_CROSS="-ftpp -DNPROCS=${NPROCS} -DCROSS_ -DNITER=${NITER} -DSLEEP=${SLEEP}"
CONF_COMPILE_PATH="${ROOT}/confidence_tests/compile_output"
CONF_EXEC_PATH="${ROOT}/confidence_tests/exec_output"
CONF_LOG_PATH="${ROOT}/confidence_tests"

#for CONFORMANCE TESTS
FEATURE_COMPILE_PATH="${ROOT}/should_pass/compile_output"
FEATURE_EXEC_PATH="${ROOT}/should_pass/exec_output"
FEATURE_LOG_PATH="${ROOT}/should_pass"

#for SPECIFIC TESTS
FEW_COMPILE_PATH="${ROOT}/few_tests/compile_output"
FEW_EXEC_PATH="${ROOT}/few_tests/exec_output"
FEW_LOG_PATH="${ROOT}/few_tests"




#for NON-CONFORMANCE TESTS
NONCONF_COMPILE_PATH="${ROOT}/should_fail/compile_output"
NONCONF_EXEC_PATH="${ROOT}/should_fail/exec_output"
NONCONF_LOG_PATH="${ROOT}/should_fail"


#E-mail stuff
SUBJ=
LOGFILE=
EMAIL_LIST=
EMAIL_BODY=

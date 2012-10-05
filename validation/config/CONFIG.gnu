# path vals
ROOT="/home/sidjana/caf_testsuite/validation"
BIN_PATH="${ROOT}/bin"

#for ALL TESTS
COMPILER="OpenUH"
FC="uhcaf"
NPROCS="4"
NITER="5"
SLEEP="1"
FFLAGS="-ftpp -DNPROCS=${NPROCS} -DNITER=${NITER} -DSLEEP=${SLEEP}"
LAUNCHER="cafrun -n ${NPROCS}"
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

#E-mail stuff
SUBJ=
LOGFILE=
EMAIL_LIST=
EMAIL_BODY=

KERNELS_PATH=./performance/kernels
MICROBENCH_PATH=./performance/microbenchmarks
NPB_PATH=./performance/npb
VALID_PATH=./validation


############## HELP #################

help default:
	@printf '\n%10s\n' " For CAF-performance test suite:"
	@printf '\n%10s\n' " Usage: $(MAKE)  performance ARGS=[OPTIONS]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ compile_<suite>:" "compiles and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ run_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ clean_<suite>:" "cleans up the logs, executables and all previous history of the regression runs"
	@printf '%-20s%-90s\n' " |_ <suite>:" "[npb | microbenchmarks | kernels]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"

################# PERFORMANCE TESTS ###################
test_performance: compile_performance run_performance


### COMPILE PERFORMANCE TESTS

compile_performance: compile_kernels  compile_microbenchmarks compile_npb

compile_kernels:
	cd $(KERNELS_PATH)/tests ;

compile_microbenchmarks:
	cd $(MICROBENCH_PATH) ; sh test_microbenchmarks.sh compile;

compile_npb:
	cd $(NPB_PATH); sh test-npb.sh compile ;


### EXECUTE PERFORMANCE TESTS
run_performance: run_kernels  run_microbenchmarks run_npb

run_kernels:
	cd $(KERNELS_PATH)/tests ;

run_microbenchmarks:
	cd $(MICROBENCH_PATH) ;test_microbenchmarks.sh run;

run_npb:
	cd $(NPB_PATH) ; source test-npb.sh execute ;




################ VALIDATION TESTS ###################
validate_tests: config/CONFIG
	cd $(VALID_PATH) ; ./validate




################# CLEAN-UP ###################
.PHONY: clean
clean: clean_performance clean_validation


### CLEAN PERFORMANCE TESTS
clean_performance: clean_kernels clean_microbenchmarks clean_npb

clean_kernels:
	cd $(KERNELS_PATH) ; sh clean.sh

clean_microbenchmarks:
	cd $(MICROBENCH_PATH) ; sh clean.sh

clean_npb:
	cd $(NPB_PATH) ;  sh clean.sh

### CLEAN VALIDATION TESTS
clean_validation:
	cd $(VALID_PATH) ; sh clean.sh tests_output



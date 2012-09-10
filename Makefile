KERNELS_PATH=./performance/kernels
MICROBENCH_PATH=./performance/microbenchmarks
NPB_PATH=./performance/npb
VALID_PATH=./validation


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




################# VALIDATION TESTS ###################
validate_tests:
	cd $(VALID_PATH) ; ./validate




################# CLEAN-UP ###################
clean_all: clean_performance clean_validation


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
	cd $(VALID_PATH) ; sh clean.sh





################# HELP ME !!! ###################
help:
	cd support; cat README


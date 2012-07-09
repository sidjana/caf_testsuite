KERNELS_PATH=./performance/kernels
MICROBENCH_PATH=./performance/microbenchmarks
NPB_PATH=./performance/npb



compile_performance: compile_kernels  compile_microbenchmarks compile_npb

compile_kernels:
	cd $(KERNELS_PATH)/tests ; 

compile_microbenchmarks: 
	cd $(MICROBENCH_PATH) ; source test_microbenchmarks.sh compile;

compile_npb: 
	cd $(NPB_PATH); source test-npb.sh compile ;



run_performance: run_kernels  run_microbenchmarks run_npb

run_kernels:
	cd $(KERNELS_PATH)/tests ;	

run_microbenchmarks:
	cd $(MICROBENCH_PATH) ;test_microbenchmarks.sh run;

run_npb:
	cd $(NPB_PATH) ; source test-npb.sh execute ;




clean_all: clean_performance


clean_performance: clean_kernels clean_microbenchmarks clean_npb

clean_kernels:
	cd $(KERNELS_PATH) ; source clean.sh 

clean_microbenchmarks:
	cd $(MICROBENCH_PATH) ; source clean.sh 

clean_npb:
	cd $(NPB_PATH) ;  source clean.sh 

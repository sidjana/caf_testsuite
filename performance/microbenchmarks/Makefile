
help default: ./test_microbenchmarks.sh 
	@echo "Usage: make [ compile | execute | complete/all ]"

compile: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh compile

run: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh execute

complete all: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh  complete

veryclean: 
	@rm -rf log regression_op bin

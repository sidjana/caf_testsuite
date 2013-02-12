
help default: ./test_kernels.sh
	@echo "Usage: make [ compile | execute | complete/all ]"

compile: ./test_kernels.sh
	@./test_kernels.sh compile

run: ./test_kernels.sh
	@./test_kernels.sh execute

complete all: ./test_kernels.sh
	@./test_kernels.sh  complete

veryclean: 
	@rm -rf log regression_op bin

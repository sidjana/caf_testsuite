COMPILER ?= uhcaf

help default: ./test_microbenchmarks.sh 
	@echo "Usage: make [ compile|execute|complete|clean|cleanall ] [COMPILER=uhcaf|ifort|g95]"

compile: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh compile $(COMPILER)

run: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh execute $(COMPILER)

complete all: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh  complete $(COMPILER)

.PHONY: clean


clean: 
	@rm -rf bin

cleanall:  clean
	@rm -rf log regression_op 

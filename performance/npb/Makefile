SHELL:=/bin/bash

TEMP_1:=$(shell mkdir -p ./bin)
CLASS=U
NPROCS=1
SFILE=config/suite.def
COMPILER?=uhcaf

default: header
	@ sys/print_instructions

BT: bt
bt: header
	cd BT; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS) SUBTYPE=$(SUBTYPE)

SP: sp
sp: header
	cd SP; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

LU: lu
lu: header
	cd LU; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

MG: mg
mg: header
	cd MG; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

FT: ft
ft: header
	cd FT; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

IS: is
is: header
	cd IS; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

CG: cg
cg: header
	cd CG; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

EP: ep
ep: header
	cd EP; $(MAKE) NPROCS=$(NPROCS) CLASS=$(CLASS)

DT: dt
dt: header
	cd DT; $(MAKE) CLASS=$(CLASS)

# Awk script courtesy cmg@cray.com, modified by Haoqiang Jin
suite:
	@ awk -f sys/suite.awk SMAKE=$(MAKE) $(SFILE) | $(SHELL)


# It would be nice to make clean in each subdirectory (the targets
# are defined) but on a really clean system this will won't work
# because those makefiles need config/make.def

.PHONY: clean

clean:
	@rm -f core
	@rm -f *~ */core */*~ */*.o */npbparams.h */*.obj */*.exe
	@rm -f MPI_dummy/test MPI_dummy/libmpi.a
	@rm -f sys/setparams sys/makesuite sys/setparams.h
	@rm -f btio.*.out*
	@rm -f */*.mod ./bin/*.*.*

cleanall: clean ./test_npb.sh
	@rm -f config/suite.def config/make.def
	@rm -rf bin
	@./test_npb.sh cleanall


header:
	@ sys/print_header


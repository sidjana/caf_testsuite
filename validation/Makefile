##########################################
ARMCI_SRC  = ${ARMCI_HOME}
GASNET_SRC = ${GASNET_HOME}
NETWORK =  ${COMM_NETWORK}

COMM_LAYER ?= ARMCI
COMM_NETWORK ?=MPI
###########################################

FC   = uhf90
#FFLAGS = -coarray -show
FFLAGS = -coarray
#FFLAGS += -keep -Wb,-trlow -Wb,-tslow -flist
TEST =
UH_LIBS=$(TOOLROOT)/lib/gcc-lib/x86_64-open64-linux/4.2

LD = uhf90

# ARMCI and GASNET env variables

ifeq ($(COMM_LAYER), ARMCI)
	COMM_BASE = armci
	ARMCI_LIB = $(ARMCI_SRC)/lib/LINUX64
	ARMCI_INCLUDE = $(ARMCI_SRC)/src
	CDEFS = -DARMCI=1
	ifeq ($(NETWORK),IB)
		LDFLAGS = -libverbs
	endif
	LDFLAGS += -L$(ARMCI_LIB) -larmci
else
ifeq ($(COMM_LAYER), GASNET)
	COMM_BASE = gasnet
	GASNET_LIB = $(GASNET_SRC)/lib
	GASNET_INCLUDE = $(GASNET_SRC)/include
	CDEFS = -DGASNET=1
	ifeq ($(NETWORK), IB)
		LDFLAGS = -libverbs
		LDFLAGS += -L$(GASNET_LIB) -lgasnet-ibv-par -lgasnet_tools-par
	else
	ifeq ($(NETWORK), MPI)
		LDFLAGS = -L$(GASNET_LIB) -lgasnet-mpi-par -lgasnet_tools-par -lammpi
	endif
	endif
endif
endif

COMM_LIB = -L$(UH_LIBS) -lcomm-$(COMM_BASE) -L$(MPI_LIB) -lmpi  $(LDFLAGS)


$(TEST): $(TEST).o
	$(LD) -o $@ $^ $(COMM_LIB)

$(TEST).o: $(TEST).f90
	$(FC) -O2 -c -fno-second-underscore $(FFLAGS) $<

.PHONY: clean
clean:
	rm -rf *.I *.i *.B *.o *.s $(TEST)

very_clean: clean
	rm -rf should_pass/compile_output/*.* should_pass/exec_output/*.*


.PHONY: clobber
clobber: clean
	rm -rf *.w2f.f *.l *.t *.mod

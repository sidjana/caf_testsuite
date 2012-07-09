
SHELL = /bin/sh

include user.def

GCC=gcc

NITER ?= 100

FC   = uhcaf

COMM_LAYER ?= GASNET
CAFFLAGS = --layer=$(COMM_LAYER) -v
FFLAGS = -O3 -ftpp -DNITER=$(NITER) #-Wf,-Z -show -keep -Wb,-trlow  -Wb,-tslow
LOPT_SET=LAUNCHER_OPTS="$(RUNOPT2)"

LD = $(FC)

#COMM_LIB = -L$(UH_LIBS) -lcomm-$(COMM_BASE) -L$(MPI_LIB) -lmpi  $(LDFLAGS)

BIN = $(BENCH_BINDIR)/put_latency $(BENCH_BINDIR)/get_latency $(BENCH_BINDIR)/put_bandwidth $(BENCH_BINDIR)/get_bandwidth $(BENCH_BINDIR)/ping_pong $(BENCH_BINDIR)/broadcast $(BENCH_BINDIR)/bidirectional $(BENCH_BINDIR)/noncontiguous

all: put_latency get_latency put_bandwidth get_bandwidth ping_pong bidirectional broadcast noncontiguous

run: put-latency-run get-latency-run put-bandwidth-run get-bandwidth-run pingpong-run bidirectional-run noncontiguous-run
	# broadcast-run 

put-latency-run:
	@echo ""; echo "*** [CAF] Submitting Jobs for PUT LATENCY ***"; echo ""
	export LAUNCHER_OPTS=$(RUNOPT2)
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCORELAT) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCLAT) $(BENCH_BINDIR)/put_latency -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCORELAT) $(NPROCLAT)
	@sleep 2s

get-latency-run:
	@echo ""; echo "*** [CAF] Submitting Jobs for GET LATENCY***"; echo ""
	export LAUNCHER_OPTS=$(RUNOPT2)
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCORELAT) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCLAT) $(BENCH_BINDIR)/get_latency -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCORELAT) $(NPROCLAT)
	@sleep 2s

put-bandwidth-run:
	@echo ""; echo "*** [CAF] Submitting Jobs for PUT BANDWIDTH ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCOREBW) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCBW) $(BENCH_BINDIR)/put_bandwidth -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCOREBW) $(NPROCBW)
	@sleep 2s

get-bandwidth-run:
	@echo ""; echo "*** [CAF] Submitting Jobs for GET BANDWIDTH ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCOREBW) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCBW) $(BENCH_BINDIR)/get_bandwidth -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCOREBW) $(NPROCBW)
	@sleep 2s

pingpong-run:
	@echo ""; echo "*** [CAF] Submitting jobs for PING-PONG ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCOREPP) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCPP) $(BENCH_BINDIR)/ping_pong -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCOREPP) $(NPROCPP)
	@sleep 2s

bidirectional-run:
	@echo ""; echo "*** [CAF] Submitting jobs for BIDIRECTIONAL ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCOREBD) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCBD) $(BENCH_BINDIR)/bidirectional -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCOREBD) $(NPROCBD)
	@sleep 2s

broadcast-run:
	@echo ""; echo "*** [CAF] Submitting Jobs for BROADCAST ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCOREBCST) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCBCST) $(BENCH_BINDIR)/broadcast -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCOREBCST) $(NPROCBCST)
	@sleep 2s

noncontiguous-run:
	@echo ""; echo "*** [CAF] Submitting jobs for NONCONTIGUOUS DATA ***"; echo ""
	$(LOPT_SET) $(JOBCMD) $(NCOREOPT) $(NCORENC) $(JOBOPT) $(RUNCMD) $(RUNOPT) $(NPROCOPT) $(NPROCNC) $(BENCH_BINDIR)/noncontiguous -- $(CAF_PATH) $(COMM_LAYER) $(CLUSTER) $(NCORENC) $(NPROCNC)
	@sleep 2s

put_latency: put_latency.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

get_latency: get_latency.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

put_bandwidth: put_bandwidth.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

get_bandwidth: get_bandwidth.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

ping_pong: ping_pong.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

bidirectional: bidirectional.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

broadcast: broadcast.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

noncontiguous: noncontiguous.o rtc.o
	$(LD) -- $(FFLAGS) -o $(BENCH_BINDIR)/$@ $^

%.o: %.f90
	$(FC) $(CAFFLAGS)  -c $(FFLAGS) $<

rtc.o: ../rtc.c
	$(GCC) -c -D$(TIMER_ARCH) $^ -o $@

clean:
	rm -rf *.I *.i *.B *.o  *.s *.t *.w2f.f *~ core */*~ l0335194.*

clobber: clean
	rm -rf $(BIN) $(CAF_PATH)/*

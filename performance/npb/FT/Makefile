SHELL=/bin/sh
BENCHMARK=ft
BENCHMARKU=FT

include ../config/make.def

include ../sys/make.common

OBJS = ft.o mco_reduce.o ${COMMON}/${RAND}.o ${COMMON}/print_results.o ${COMMON}/timers.o \
	   ${COMMON}/wtime.o

${PROGRAM}: config ${OBJS}
	${CAFLINK} ${CAFLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}



.f.o:
	${CAFCOMPILE} $<

.F.o:
	${CAFCOMPILE} $<

ft.o:  ft.F mco_reduce.mod  global.h mpinpb.h npbparams.h
mco_reduce.mod:   mco_reduce.o
mco_reduce.o:     mco_reduce.f

clean:
	- rm -f *.o *~ mputil*
	- rm -f ft npbparams.h core

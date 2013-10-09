SHELL=/bin/bash
BENCHMARK=ft
BENCHMARKU=FT

include ../config/make.def

include ../sys/make.common

OBJS = ft.o mco_reduce.o ${COMMON}/${RAND}.o ${COMMON}/print_results.o ${COMMON}/timers.o \
	   ${COMMON}/wtime.o

${PROGRAM}: config ${OBJS}
	${CAFLINK} ${CAFLINKFLAGS} -o ${PROGRAM} ${OBJS}



.f.o:
	${CAFCOMPILE} $<

.F.o:
	${CAFCOMPILE} $<

ft.o:  ft.F mco_reduce.mod  global.h npbparams.h

mco_reduce.mod:   mco_reduce.o

mco_reduce.o:     mco_reduce.f

clean:
	- rm -f *.o *~ mputil* *.mod
	- rm -f ft npbparams.h core

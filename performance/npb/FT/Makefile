SHELL=/bin/sh
BENCHMARK=ft
BENCHMARKU=FT

include ../config/make.def

include ../sys/make.common

OBJS = ft_caf.o ft.o ${COMMON}/${RAND}.o ${COMMON}/print_results.o ${COMMON}/timers.o \
	   ${COMMON}/wtime.o

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}



.f.o:
	${FCOMPILE} $<

ft.o:  ft_caf.f ft.f  global.h mpinpb.h npbparams.h

clean:
	- rm -f *.o *~ mputil*
	- rm -f ft npbparams.h core

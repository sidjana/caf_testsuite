c---------------------------------------------------------------------
c---------------------------------------------------------------------
        module cg_params
c---------------------------------------------------------------------
c---------------------------------------------------------------------

          implicit none

          include 'mpinpb.h'
          include 'timing.h'
          include 'npbparams.h'

c---------------------------------------------------------------------
c  num_procs must be a power of 2, and num_procs=num_proc_cols*num_proc_rows.
c  num_proc_cols and num_proc_cols are to be found in npbparams.h.
c  When num_procs is not square, then num_proc_cols must be = 2*num_proc_rows.
c---------------------------------------------------------------------
          integer    num_procs 
          parameter( num_procs = num_proc_cols * num_proc_rows )

          integer    nz
          parameter( nz = na*(nonzer+1)/num_procs*(nonzer+1)+nonzer
     >              + na*(nonzer+2+num_procs/256)/num_proc_cols )

      end module

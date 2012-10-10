! SYNC ALL with the STAT specifier

      program sync_stat
      use cross_test
      use, intrinsic:: iso_fortran_env

        implicit none

        integer :: num[*]
        integer :: i, rank
        integer :: stat_var = 0 

        rank=this_image()
        num=rank

        if (NPROCS == 1) then
          print *, "Config error: NPROCS should be greater than 1"
          call EXIT(0)
        end if

        if (rank == 1) then
            STOP
        else
            call sleep(SLEEP)
#ifndef CROSS_
            sync all(STAT=stat_var)
            if ( stat_var /= STAT_STOPPED_IMAGE) then
              call EXIT(1)
            end if
#else
            sync all
            if ( stat_var == STAT_STOPPED_IMAGE) then
              call EXIT(1)
            end if
#endif
        end if

      end program


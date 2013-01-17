! SYNC ALL with the STAT specifier

      program sync_stat
      use, intrinsic:: iso_fortran_env

        implicit none

        integer :: num[*]
        integer :: i, rank
        integer :: stat_var = 0

        rank=this_image()
        num=rank

        if (NPROCS == 1) then
          print *, "Config error: NPROCS should be greater than 1"
          STOP 1
        end if

        if (rank == 1) then
            print *,"image 1 all clear "
        else
            call sleep(SLEEP)
            sync all(STAT=stat_var)
            if ( stat_var /= STAT_STOPPED_IMAGE) then
              STOP 1
            end if
        end if

      end program


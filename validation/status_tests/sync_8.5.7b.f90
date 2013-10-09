

      program errmsg_stat
        use, intrinsic:: iso_fortran_env
        integer :: stat_var, rank, size
        integer :: arr(1)
        arr(1) = 1

        rank = this_image()
        size = num_images()

        cross_err = 0
        stat_var = 0

        if (NPROCS == 1) then
           print *, "Config error: NPROCS should be greater than 1"
           STOP 1
        end if

        if (rank == 1 ) then
           print *, "rank 1 all clear"
        else
           call sleep(SLEEP)
           sync images(arr, STAT=stat_var)
           if ( stat_var /= STAT_STOPPED_IMAGE) then
              STOP 1
           end if
        end if


      end program


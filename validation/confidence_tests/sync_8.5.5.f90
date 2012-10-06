! This program checks for errmsg= stat= specifiers for sync calls


      program errmsg_stat
        use cross_test
        use, intrinsic:: iso_fortran_env
        integer :: stat_var, rank, size
        integer :: other_images(1)
        other_images(1) = 2

        rank = this_image()
        size = num_images()

        cross_err = 0
        do i = 1, NITER

          stat_var = 0
          sync all (STAT=stat_var)

        if (rank .gt. 2) then
            other_images(1) = 1
#ifndef CROSS_
            stop
#endif
            sync images(other_images)
        else if (rank .eq. 1) then
            other_images(1) = 2
                      call sleep(SLEEP)
              sync images(other_images, STAT=stat_var)
              if ( stat_var /= stat_stopped_image) then
                cross_err = cross_err + 1
              end if
        end if
        end do

#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif


      end program


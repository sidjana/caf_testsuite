! This program checks for errmsg= stat= specifiers for sync calls


      program errmsg_stat

        use, intrinsic:: iso_fortran_env
        integer :: stat_var, rank, size
        integer :: other_images(1)
        other_images(1) = 2

        rank = this_image()
        size = num_images()
        stat_var = 0
        cross_err = 0

        sync all

        if (rank .gt. 2) then
            other_images(1) = 1
            stop
            sync images(other_images)
        else if (rank .eq. 1) then
            other_images(1) = 2
            call sleep(8)
            sync images(other_images, STAT=stat_var)
            if ( stat_var /= stat_stopped_image) then
                call EXIT(5)
            end if
        end if


      end program

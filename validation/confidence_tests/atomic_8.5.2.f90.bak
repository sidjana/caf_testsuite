!Atomic subroutines

    program main

        use, intrinsic:: iso_fortran_env

        integer(atomic_int_kind) :: obj[*]
        integer :: size, rank
        integer :: j

        size = num_images()
        rank = this_image()
        obj = 0
        num = 2**rank

        if (size .eq. 1) then
          print *, "atomics test requires more than one image for verification"
          STOP
        end if

        do j = 1,NITER
            obj = 0
            sync all
            !call atomic_define(obj[1],num)
            obj[1]=num
            sync all
            if (rank == 1) then
              if ( obj /=2 .AND. obj /= 4 &
              .AND. obj /= 8 .AND. obj/=16) then
               call EXIT(4) 
              end if
            end if
            sync all
        end do


    end program


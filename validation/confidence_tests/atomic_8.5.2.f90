!Atomic subroutines

       program main
        use cross_test
        use, intrinsic:: iso_fortran_env

        integer(atomic_int_kind) :: i_obj[*]
        logical(atomic_logical_kind) :: l_obj[*] = .true.
        integer :: size, rank
        integer :: i,k, i_val
        logical :: l_val

        size = NPROCS
        rank = this_image()
        num = 2**rank

        if (NPROCS .lt. 2) then
          print *, "Config Error: Number of images must be >= 2"
          call EXIT(1)
        end if

        sync all

        do k = 1,NITER
           i_obj=1
               if (rank == 1) then
                    i_val=2
                    ! get the latest copy in cache
#ifndef CROSS_
                    call atomic_ref(i_val, i_obj)
#else
                    i_val = i_obj
#endif
                    do while (i_val .ge. 2)
                      if ( MOD(i_val,2 ) /= 0) then
                         print *, "Error for atomic_int_kind"
                         cross_err = cross_err + 1
                      end if
                      i_val = i_val / 2
                    enddo
               else
                  !Each image defines i_objo[1] multiple times
                  !This increases the chance of an incorrect
                  !implementation of atomics to mess up
#ifndef CROSS_
                     call atomic_define(i_obj[1],num)
#else
                     i_obj[1]=num
#endif
               end if

           sync all
        end do


        ! The source of the code below is
        ! ISO/IEC JTC1/SC22/WG5 N1824
        ! This is a very godd test for atomic_logical_kind coarrays

        if (rank == 1) then
        sync memory
        call atomic_define(l_obj[2],.false.)
        ! Has the effect of l_obj[q]=.false.
        else if (rank == 2) then
        l_val = .true.
        ! Spin until l_val is false
        do while (l_val)
        call atomic_ref(l_val,l_obj)
        ! Has the effect of l_val=l_obj
        end do
        sync memory
        end if


#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif




      end program


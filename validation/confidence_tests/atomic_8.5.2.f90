!Atomic subroutines

       program main
        use cross_test
        use, intrinsic:: iso_fortran_env

        integer(atomic_int_kind) :: obj[*]
        integer :: size, rank
        integer :: i,k,j

        size = NPROCS
        rank = this_image()
        num = 2**rank


        i = 0
        obj = 1

        sync all

        do k = 1, NITER
           if (rank == 1) then
               do i =0, 1000 
                   j = obj + j
               end do
               call sleep(SLEEP)
               if ( MOD(obj,2) /= 2) then
                     cross_err = cross_err + 1
               end if
           else
#ifndef CROSS_
               call atomic_define(obj[1],num)
#else
               obj[1]=num
#endif
           end if
           sync all
        end do

#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif

      end program






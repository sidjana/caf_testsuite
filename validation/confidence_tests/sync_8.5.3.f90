! SYNC ALL without the STAT= specifier 

      program item12_1
      use cross_test

        implicit none

        integer :: num[*]
        integer :: i, rank

        rank=this_image()
        num=rank
#ifndef CROSS_
        sync all
#endif
        do i = 1,NITER
              num = 0
#ifndef CROSS_
              sync all
#endif
              if (rank == 1) then
                call sleep(SLEEP)
                num = i*rank
#ifndef CROSS_
                sync all
#endif
              else
#ifndef CROSS_
                sync all
#endif
                if (num[1] /= i) then
                  cross_err = cross_err + 1
                end if
              end if
#ifndef CROSS_
             sync all
#endif
        end do
#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif

      end program


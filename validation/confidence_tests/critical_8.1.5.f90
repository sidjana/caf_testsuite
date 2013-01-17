! CRITICAL sections

         program critical
         use  cross_test

         integer :: num[*], rank, i,j
         integer,parameter :: M=100000
         integer :: dummy(M)


         rank = this_image()
        if(NPROCS .gt. 1) then

           do i = 1,NITER
                  num = 0
                  sync all
#ifndef CROSS_
            critical
#endif

                do j = 1 , M
                  num[1] = num[1] + 1
                  dummy(j)=dummy(j)+1
                end do
#ifndef CROSS_
             end critical
#endif
             sync all

             if (rank == 1 .and. num /=(M*NPROCS)) then
                cross_err = cross_err + 1
                print *,"num = ", num
             end if
             sync all
           end do
#ifndef CROSS_
           print * , "call before", rank, "err=", cross_err
           call calc_ori(cross_err)
           print *, "call after", rank
#else
           call calc(cross_err)
#endif

        else
          print *, "Config Err: NPROCS shoud be > 1"
          call EXIT (1)
        end if


           end program


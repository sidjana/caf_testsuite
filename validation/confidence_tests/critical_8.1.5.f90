! CRITICAL sections


         program item12
         use  cross_test

            integer :: num[*], rank, size, i
            integer :: cross_err[*]
            rank = this_image()
            size = num_images()

            if (rank /= 1) then
              call sleep(3) ! giving img1 a head start
            end if
            do i = 1,5
            num = 0
#ifndef CROSS_
            critical
#endif

                   if (rank == 1) then
                     call sleep(4)
                     num = rank
                   else
                     if (num[1] == 0) then
                       cross_err = cross_err + 1
                     end if
                   end if

#ifndef CROSS_
             end critical
#endif
             sync all
           end do
           print *, rank,":complete", cross_err
           call calc(cross_err)

!            if (rank == 1) then
!              do i = 2 , size
!                cross_err = max(cross_err,cross_err[i])
!                print *, cross_err
!              end do
!              if ((cross_err*1.0)/5 .ge. 0.5) then
!                call EXIT (7)
!              end if 
!            end if

           end program item12


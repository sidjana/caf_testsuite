! CRITICAL sections

         program critical
         use  cross_test

            integer :: num[*], rank, size, i
            rank = this_image()
            size = num_images()

           do i = 1,NITER
                  num = 0
                  sync all
                  if (rank /= 1) then
                    call sleep(SLEEP) ! giving img1 a head start
                  end if
#ifndef CROSS_
            critical
#endif
                   if (rank == 1) then
                     call sleep(SLEEP)
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
#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif
           end program


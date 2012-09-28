! SYNC IMAGES(*) .NEQ. SYNC ALL - other images must not wait for each other

PROGRAM item12_c
      use cross_test

      IMPLICIT NONE

      INTEGER :: total_images, rank, i
      INTEGER :: arr (1)
      INTEGER :: num[*]

      rank=this_image()
      total_images=num_images()
      arr(1)=2

      cross_err = 0

      if (total_images .lt. 3) then
            print *, "run program with num_images >= 3"
            call EXIT(3)
      end if

      do i = 1 , 4
          num = 0
          sync all
          if(rank == 2)  then
#ifndef CROSS_
               sync images(*)
#endif
          else if(rank == 1) then
               call sleep(5)
               num = rank
#ifndef CROSS_
               sync images(arr)
#endif
          else
#ifndef CROSS_
               sync images(arr)
#endif
               if (num[1] /= 0) then
                    cross_err = cross_err + 1
               end if
          end if
          sync all
      end do

#ifndef CROSS_
           call calc_ori(cross_err)
#else
           call calc(cross_err)
#endif


END PROGRAM

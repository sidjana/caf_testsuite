! SYNC IMAGES(*) .NEQ. SYNC ALL - other images must not wait for each other

PROGRAM item12_c
      IMPLICIT NONE

      INTEGER :: total_images, rank, i
      INTEGER :: arr (1)
      INTEGER :: num[*]

      rank=this_image()
      total_images=num_images()
      arr(1)=1
      num = 0

      if (total_images .le. 3) then
               print *, "run program with num_images > 3"
                STOP
          end if

      do i = 1 , 4
          num = 0
          sync all
          if(rank == 1)  then
               sync images(*)

          else if(rank == 2) then
               call sleep(5)
               num = rank
               sync images(arr)

          else
               sync images(arr)
               if (num[2] /= 0) then
                 print *, "ERROR"
               end if

          end if
          sync all

      end do
          print *, rank, " reached"

END PROGRAM

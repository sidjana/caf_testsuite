PROGRAM item12_c
IMPLICIT NONE

INTEGER :: total_images, rank
INTEGER :: arr (1)
INTEGER :: num[*]

rank=this_image()
total_images=num_images()
arr(1)=1

  if(rank == 1)  then
       sync images(*)
       if (num[3] .eq. 3) then
         print *,"ERROR"
       end if
  else if(rank == 2) then
       sync images(arr)
       if (num[3] .eq. 4) then
         ! if 2 sees the change in 3, that means that 2
         !waited for image three to complete writing to its local num. This violates
         !the spec
         print *,"ERROR"
       end if
  else 
       call sleep(5)
       num=num+1
       sync images(arr)
  end if

END PROGRAM

! sync_images(*) not same as sync all
PROGRAM item12_c
IMPLICIT NONE

INTEGER :: total_images, rank
INTEGER :: arr (1)
INTEGER :: num[*]

rank=this_image()
total_images=num_images()
arr(1)=1
num = rank

  if(rank == 1)  then
       print * , "1 before sync"
       sync images(*)
       print *, "1 after sync"
       !if (num[3] .eq. 3) then
       !  print *,"ERROR by 1"
       !end if
  else if(rank == 2) then
       print *, "2 before sync(1)"
       sync images(arr)
       print *, "2 after sync(1)"
       !if (num[3] .eq. 4) then
         ! if 2 sees the change in 3, that means that 2
         !waited for image three to complete writing to its local num. This violates
         !the spec
        ! print *,"ERROR by 2"
       !end if
  else 
       call sleep(5)
       num=num+1
       print *, "3+4 before sync(1)"
      sync images(arr)
       print *, "3+4 after sync(1)"

  end if
      print *, rank, " reached"
END PROGRAM

!SYNC IMAGES(arr) must sync with all images listed in arr()

PROGRAM item12_c

    IMPLICIT NONE

    INTEGER :: total_images, rank, i
    INTEGER :: arr(1)
    INTEGER :: num[*]

    rank=this_image()
    total_images=num_images()

    arr(1)=1

    do i = 1 , 4
       num = 0
       sync all

       if(rank == 1)  then
            num = rank * 10
            call sleep(3)  ! giving other images a head start
            sync images(*)
       else
            sync images(1)
            if (num[1] .eq. 0) then
              print *,"ERROR"
            end if
       end if
       sync all
    end do

END PROGRAM

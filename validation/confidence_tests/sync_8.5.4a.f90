!SYNC IMAGES(arr) must sync with all images listed in arr()

PROGRAM item12_c
    use cross_test

        IMPLICIT NONE

        INTEGER :: total_images, rank, i
        INTEGER :: arr(1)
        INTEGER :: num[*]

        rank=this_image()
        total_images=num_images()

        arr(1)=1

#ifndef CROSS_
        sync all
#endif

        do i = 1,5
              num = 0
              sync all
              if(rank == 1)  then
                  call sleep(5)  ! giving other images a head start
                  num = rank
#ifndef CROSS_
                  sync images(*)
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

      end program


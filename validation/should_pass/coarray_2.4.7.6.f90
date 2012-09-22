! For a coindexed object, its cosubscript list determines the image
! index in the same way that a subscript list determines the subscript
! order value for an array element

            program image
            implicit none
            integer :: arr[2,*], rank, i, j, size
            integer :: src(2,2)

            src = reshape((/1, 2, 3, 4/),shape(src))

            rank = this_image()
            size = num_images()
            arr = rank

            sync all

            do i = 1,2
              do j = 1,2
                src(i,j) = (j-1)*2 + i
                if ( arr[i,j] /= src(i,j) ) then
                  print *, "ERROR"
                end if
              end do
            end do

            end program

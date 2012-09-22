!access to coarray without [] is to local object
    program main
        implicit none
        integer :: a[*]
        integer :: rank,i

        rank = this_image()
        a[rank] = rank

        sync all

        if (rank == 1) then
          do i = 1 , num_images()
            if (a[i] /= i) then
                print * , "ERROR"
            end if 
          end do
        end if
end program main

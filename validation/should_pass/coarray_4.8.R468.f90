!access to coarray without [] is to local object
    program main
        implicit none
        integer :: a[*]
        integer :: rank,i

        rank = this_image()
        a[rank] = rank

        if (rank == 1) then
          do i = 1 , NPROCS
            if (i == rank .AND. a /= i) then
                print * , "ERROR"
                call EXIT(0)
            end if
          end do
        end if
end program main

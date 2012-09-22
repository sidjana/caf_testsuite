!declare dimension of coarray using codimension keyword
program main
    integer , codimension[*] :: pi
    integer :: i

    pi = this_image()
    sync all

    do i = 1 , num_images()
      if (pi[i] /= i) then
        print *, "ERROR"
      end if
    end do
end program main

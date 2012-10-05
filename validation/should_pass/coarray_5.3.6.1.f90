!declare dimension of coarray using codimension keyword
program main
    integer , codimension[*] :: pi
    integer :: i

    pi = this_image()
    sync all

    do i = 1 , NPROCS
      if (pi[i] /= i) then
        call EXIT(1)
      end if
    end do
end program main

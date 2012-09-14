!declare dimension of coarray using codimension keyword
program main
	implicit none
	integer, codimension[*] :: pi
    integer :: arr(2,3)[*]
    arr(:) = this_image()

end program main


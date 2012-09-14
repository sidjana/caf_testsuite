!declare dimension of coarray using codimension keyword
program main
	implicit none
	integer, codimension[*] :: pi
    integer :: arr(2,3)[*]
end program main


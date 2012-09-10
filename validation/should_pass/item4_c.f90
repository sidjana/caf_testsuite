!access to coarray without [] is to local object
program main
	implicit none
	integer :: a[*]
	integer :: rank,i
	rank = this_image()
	a[rank] = rank
	
	if (a .NE. rank) then
		write(UNIT=0,*) "Image",rank," wrong local co-object",a
	end if
	
end program main

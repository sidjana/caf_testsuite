!Specification 15. Intrinsic procedures
!ucobound()
program main
implicit none
	integer :: x[2,*]
	integer :: cb, cb2(2)
	
	cb2 = ucobound(x)
	if(cb2(1) .ne. 2 .or. cb2(2) .ne. 2) then
		write(0,*) "Error item15_c ucobound(x)"
	end if
	
	cb = ucobound(x,1)
	if(cb .ne. 2) then 
		write(0,*) "Error item15_c ucobound(x,1)"
	end if
	
	cb = ucobound(x,2)
	if(cb .ne. 2) then 
		write(0,*) "Error item15_c ucobound(x,2)"
	end if
	
end program main
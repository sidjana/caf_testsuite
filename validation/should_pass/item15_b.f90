!Specification 15. Intrinsic procedures
!lcobound()
program main
implicit none
	integer :: x[2,*]
	integer :: cb, cb2(2)
	
	cb2 = lcobound(x)
	if(cb2(1) .ne. 1 .or. cb2(2) .ne. 1) then
		write(0,*) "Error item15_b lcobound(x)"
	end if
	
	cb = lcobound(x,1)
	if(cb .ne. 1) then 
		write(0,*) "Error item15_b lcobound(x,1)"
	end if
	
	cb = lcobound(x,2)
	if(cb .ne. 1) then 
		write(0,*) "Error item15_b lcobound(x,2)"
	end if
	
end program main
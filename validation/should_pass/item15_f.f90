!Specification 15.6 Atomic subroutines
!Atomic subroutines

program main

    use, intrinsic:: iso_fortran_env
	implicit none

	integer(atomic_int_kind) :: x[*],y
   integer :: rank

	rank = this_image()
	if(rank .eq. 1) then
		call atomic_define(x[4],10)
        sync all
	else if(rank .eq. 4) then
        sync all
		call atomic_ref(y,x)
		write(*,*)"y:",y
	end if

end program main

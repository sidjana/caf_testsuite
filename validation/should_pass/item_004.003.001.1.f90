!Specification 10. Non-coarray components
!access a user define type of other image
program main
  implicit none
  type mytype
   integer :: x
   integer, pointer :: ptr
  end type mytype

  integer :: temp, temp2(3), rank
  type (mytype) :: mt(5)[*]

  !initialize
  rank = this_image()
  mt(2)%x = 2*rank
  mt(1)%x = 1*rank
  mt(3)%x = 3*rank


  temp = mt(2)[3]%x
  temp2 = mt(1:3)[4]%x

  sync all

  if(this_image() .eq. 1) then
  	if(temp .ne. 6) then
  		print *, "ERROR 10_a"
  	end if
  	if(temp2(1) .ne. 4 .OR. temp2(2) .ne. 8 .OR. temp2(3) .ne. 12) then
  		print *,  "ERROR 10_a"
  	end if
  end if

end program main

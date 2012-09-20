! user defined type

program main
  implicit none
  type mytype
   integer :: x
   integer, pointer :: ptr
  end type mytype

  integer :: temp, temp2(3), rank, total_size
  type (mytype) :: mt(5)[*]

  !initialize
  rank = this_image()
  total_size = num_images()
  mt(:)%x = rank

  if (total_size .gt. 1) then
    temp = mt(2)[1]%x
  end if
  sync all

  if(total_size .gt. 1) then
  	if(rank .eq. 2) then
      if(temp /=  1) then
  		print *,  "ERROR"
      end if
  	end if
  end if

end program main

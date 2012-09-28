!verification of image_index()


program main
implicit none
    integer :: x[2,*]
    integer :: idx, size, temp
    integer :: sub(2)
    integer :: i, j
    temp = 1
    size = num_images()

    if (num_images() .le. 3 ) then
      print * , "ERROR: num_images() should be greater than 3"
      STOP
    end if

    do j = 1 ,(size/2)
      do i = 1,2
        sub(1) = i
        sub(2) = j
        idx = image_index(x,sub)
        if(idx .ne. temp) then
          write(0,*) "ERROR: images index returned ", idx ,"instead of ", temp
        end if
        temp = temp+1
      end do
    end do


end program main

! co-indexed operands are allowed in intrinsic operations

      program coarray_in_intrisic
        integer :: num(5)[*]
        integer :: total 
  
        num(:) = this_image()
        sync all
        if (num_images() .gt. 1) then
           total = sum(num(:)[2])
           if (total /= 10) then
             print *, "ERROR"
           end if
        end if

      end program



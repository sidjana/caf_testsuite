! coarray without the co-subscripts refers to the local copy
      program square_brack

      integer :: num[*]

      num = this_image()
      rank = this_image()

      if (num /= rank) then
          print *, "ERROR"
      end if 

      end program


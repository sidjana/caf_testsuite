! A coarray on any image can be accessed directly by using cosubscripts.
! On its own image, a coarray can also be accessed without use of
! cosubscripts.

      program square_brack

      integer :: num[*]

      num = this_image()
      rank = this_image()

      sync all
      if (num /= rank .OR. num[1] /= 1) then
          print *, "ERROR"
      end if

      end program


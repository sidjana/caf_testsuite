      !Non-coarray components
      !pointer association
      !remote association is not allowed

      program main
        implicit none
        type mytype
          integer :: x
          integer, pointer :: ptr
        end type mytype

        integer, target :: temp2(3)
        integer, pointer :: localptr
        integer :: rank,i
        type (mytype), target :: mt(5)[*]

        !initialize
        rank = this_image()
        temp2(2) = 2*rank
        temp2(1) = 1*rank
        temp2(3) = 3*rank

        !component of user define type coarray points to local object
        !mt(2)[2]%ptr => temp2(2)

        !local pointer points to remote co-object
        localptr => mt(2)[2]%x

      end program main

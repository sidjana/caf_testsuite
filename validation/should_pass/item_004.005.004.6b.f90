  ! Specification 10. Non - coarray components
  ! pointer association
  ! local association is allowed
  program main
      implicit none
      type mytype
          integer::x
          integer, pointer::ptr
      end type mytype

      integer, target::temp2(3)
      integer, pointer::localptr
      integer::rank, i
      type (mytype)::mt(5)[*]

      rank = this_image()
      temp2(2) = 2*rank
      temp2 (1) = 1 * rank
      temp2 (3) = 3 * rank

      ! component of user define type coarray points to local object
      mt(2)%ptr => temp2(2)

      ! local pointer points to local co - object localptr = >mt (2) % ptr
      do i = 1, num_images()
        if (i.eq.rank) then
          if (mt (2) % ptr.ne.(2 * rank).OR.localptr.ne.(2 * rank)) then
            write (*, *) "Error item10_b"
          end if
        end if
      end do

  end program main

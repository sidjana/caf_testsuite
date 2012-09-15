

      program dummy

        integer :: num
        real, save :: a(3)[3,*], b(3,3)[*]
        real, allocatable :: c(:,:)[:], d(:)[:,:]

        allocate (c(3,3)[*])
        allocate (d(3)[3,*])


        call subr(5,a,b,c,d)

        contains
        subroutine subr(n,w,x,y,z)
            integer :: n
            real :: w(n)[n,*] ! Explicit shape
            real :: x(n,*)[*] ! Assumed size
            real :: y(:,:)[*] ! Assumed shape
            real, allocatable :: z(:)[:,:] ! Allocatable
        end subroutine
      end program

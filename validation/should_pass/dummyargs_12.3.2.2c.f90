!A dummy argument of a procedure is permitted to be a coarray. It may be of explicit shape,
!assumed size, assumed shape, or allocatable

program main
        implicit none
        integer :: i, tmp(10), rank
        integer :: a(10)[3,*], b(10,10)[*], c(2,2)[*]
        integer, allocatable :: d(:)[:]

        rank = this_image()
        a = rank
        b = rank * 2
        c = rank * 3

        call subr(10,a,b,c(::2,::2),d)

        sync all
        if (rank == 1) then
           do i = 1 , NPROCS
             tmp = i
             if (d(-5)[i] /= tmp(1)) then
                  print * , "ERROR Allocatable dummy argument"
                  call EXIT(1)
             end if
           end do
        end if

        sync all

        deallocate(d)

contains
        subroutine subr(n,w,x,y,z)
                integer :: n
                integer :: w(n)[2,*] !explicit shape,
                integer :: x(5,0:*)[*] !assumed size,
                integer :: y(:,:)[*] !assumed shape
                integer :: temp
                integer, allocatable :: z(:)[:] !allocatable
                integer :: rank

                rank = this_image()

                allocate(z(-10:-1)[*])
                z = rank

                if (lbound(x,1)/=1 .OR.     &
                    lbound(x,2)/=0 .OR.     &
                    ubound(x,1)/=5 ) then

                   print * , "ERROR assumed size"
                   call EXIT(1)

                end if

       end subroutine subr
end program main

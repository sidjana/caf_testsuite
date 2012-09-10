!A dummy argument of a procedure is permitted to be a coarray. It may be of explicit shape,
!assumed size, assumed shape, or allocatable

!in openuh, assumed shape always return 0 , fail deallocate
!in g95, reference to a coobject gives gives coarray read failure

program main
        implicit none
        real :: i(4)	
        real :: a(10)[2,*], b(10,10)[*], c(2,2)[*] 
        real, allocatable :: d(:)[:]

        a(1) = 4
        b(1,1) = 5
        c(1,1) = 6

        call subr(10,a,b,c,d)
        
        !d(1) = 45

        !write(*,*) "d : ", d(1)[2]
        write(*,*) "Hello world!!"

        !deallocate(d)

contains
        subroutine subr(n,w,x,y,z)
                integer :: n
                real :: w(n)[n,*] !explicit shape, 
                real :: x(n,*)[*] !assumed size, 
                real :: y(:,:)[*] !assumed shape
                real :: temp
                real, allocatable :: z(:)[:] !allocatable

                allocate(z(1:10)[*])
                z(1)[this_image()] = this_image() * 10

                write(*,*) "a : ",w(1)[1,1]
                write(*,*) "b : ",x(1,1)[1]
                write(*,*) "c : ",y(1,1)[1]
                !write(*,*) "d : ",z(1)

				
                if(this_image() .eq. 1) then
                        temp = z(1)[4]
                else
                        temp = z(1)[this_image() - 1]
                end if
                write(*,*) "d : ",this_image(),"=>", temp
        end subroutine subr
end program main


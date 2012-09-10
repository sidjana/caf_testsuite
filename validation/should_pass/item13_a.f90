PROGRAM item13
IMPLICIT NONE

INTEGER :: a1[*], a2[*]

!a2[2]=0

if (a2[this_image()] .eq. 0) then
write(*,*) this_image(),' error occured'
stop
else
write(*,*) this_image(),' result = ',a1[this_image()]/a2[this_image()]
endif

write(*,*) this_image(),'End of program '

END PROGRAM item13

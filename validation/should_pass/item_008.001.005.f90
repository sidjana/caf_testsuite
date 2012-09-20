! CRITICAL sections
PROGRAM item12
IMPLICIT NONE
INTEGER :: i

i=this_image()

critical 
write(*,*) this_image(),' Statement 1'
call sleep(5)
write(*,*) this_image(),' Statement 2'
end critical

END PROGRAM item12

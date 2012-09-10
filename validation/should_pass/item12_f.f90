PROGRAM item12
IMPLICIT NONE

      LOGICAL, VOLATILE :: locked[*]=.true.
      INTEGER(4) :: test, g, h

      test=this_image()
      if(test==g) then
      sync memory
      locked[h]=.false.
      write(*,*) this_image(),' Entered the sync memory'
      sync memory
      endif
END PROGRAM item12

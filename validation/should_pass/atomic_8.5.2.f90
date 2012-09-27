!Atomic subroutines

    program main

        use, intrinsic:: iso_fortran_env

        integer(atomic_int_kind) :: sca[*]
        integer :: size, rank
        integer :: j

        size = num_images()
        rank = this_image()
        sca = 0
        num = 2**rank
        if (size .eq. 1) then
          print *, "atomics test requires more than one image for verification"
          STOP
        end if

        do j = 1,100000
            sca = 0
            sync all
            if(rank /= 1) then
              call atomic_define(sca[2],num)
              !sca[1] = num
              sync all
            else
              sca = 2
              sync all
              if ( sca /=2 .AND. sca /= 4 &
              .AND. sca /= 8 .AND. sca/=16) then
                print *, "ERROR : " ,  rank
              end if
            end if
            sync all
        end do


    end program


       ! 8
       !   9     integer(atomic_int_kind) :: x[*],y
       !    10    integer :: rank
       !     11
       !      12     rank = this_image()
       !       13     if(rank .eq. 1) then
       !          14         call atomic_define(x[4],10)
       !           15         sync all
       !            16     else if(rank .eq. 4) then
       !               17         sync all
       !                18         call atomic_ref(y,x)
       !                 19     end if



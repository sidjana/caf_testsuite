!declare dimension of coarray using codimension keyword

program main
    integer , codimension[*] :: i_sca, i_arr(2,3)
    integer , allocatable, codimension[:] :: i_all_sca, i_all_arr(:,:)
    real    , codimension[*] :: r_sca, r_arr(2,3)
    real    , allocatable, codimension[:] :: r_all_sca, r_all_arr(:,:)
    integer :: rank

    rank = this_image()

    i_sca = rank
    i_arr = rank
    r_sca = rank
    r_arr = rank

    ALLOCATE(i_all_sca[*])
    ALLOCATE(i_all_arr(2,3)[*])
    ALLOCATE(r_all_sca[*])
    ALLOCATE(r_all_arr(2,3)[*])
    print *, "allocation complete"

    i_all_sca = rank
    i_all_arr = rank
    r_all_sca = rank
    r_all_arr = rank

    sync all

    do i = 1 , NPROCS
    print *, "image " , rank, "in iteration ", i
      if (i_sca[i] /= i .OR. i_arr(2,2)[i] /= i   .OR.  &
          r_sca[i] /= i .OR. r_arr(2,2)[i] /= i   .OR.  &
          i_all_sca[i] /= i .OR. i_all_arr(2,2)[i] /= i .OR. &
          r_all_sca[i] /= i .OR. r_all_arr(2,2)[i] /= i      &
          ) then
          print *, "Error in semantics of coindexed object on image", &
          i, "when declared with 'codimension' keyword"
          call EXIT(1)
        end if
   end do
  sync all
    DEALLOCATE(i_all_sca)
    DEALLOCATE(i_all_arr)
    DEALLOCATE(r_all_sca)
    DEALLOCATE(r_all_arr)
end program main

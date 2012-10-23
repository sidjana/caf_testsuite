! For a coindexed object, its cosubscript list determines the image
! index in the same way that a subscript list determines the subscript
! order value for an i_array element

       program image
       implicit none

       integer :: rank, co_i, co_j, co_k, i_arr_i, i_arr_j
       integer,parameter :: X=3,Y=2, M=2, N=1
       integer, parameter  :: P=1, Q=-1

       integer :: i_sca[1:M,1:N,*]
       integer, allocatable :: i_arr(:,:)[:,:,:]
       real :: r_sca[1:M,1:N,*]
       real, allocatable :: r_arr(:,:)[:,:,:]

       integer :: dim3_max, i_cnt, is_err
       real :: r_cnt


       ALLOCATE(i_arr(X,Y)[0:P,-1:Q,*])
       ALLOCATE(r_arr(X,Y)[0:P,-1:Q,*])

       is_err = 0
       rank = this_image()

       i_arr = rank
       i_sca = rank
       r_arr = rank * 1.0
       r_sca = rank * 1.0

       dim3_max = NPROCS / (M*N)

       if (MOD(NPROCS,(M*N)) .ge. 1) then
         dim3_max=dim3_max+1
       end if

       sync all

       ! ******* INTEGER SCALAR ***********
       ! testing for coindexed i_scalar
       i_cnt = 0
       do co_k =1, dim3_max - 1
         do co_j = 1,N
           do co_i = 1,M
            i_cnt = i_cnt+1
            if (i_cnt /= i_sca[co_i,co_j,co_k]) then
               print * , "Error is cosubscript translation "
               print * , "[", co_i,",",co_j,",",co_k,"]/=",i_cnt
               is_err=1
            end if
           end do
         end do
      end do

      ! for the last value of the last dimension
      do co_j = 1,N
        do co_i = 1,M
         i_cnt = i_cnt+1
         if (i_cnt .le. NPROCS) then
           if (i_cnt /= i_sca[co_i,co_j,co_k]) then
              print * , "Error is cosubscript translation "
              print * , "[", co_i,",",co_j,",",dim3_max,"]/=",i_cnt
              is_err=1
           end if
         end if
        end do
      end do


      ! *********** INTEGER ARRAY ****************
      ! testing for allocatable coindexed i_array
      i_cnt = 0
      do co_k =1, dim3_max - 1
         do co_j = -1,Q
           do co_i = 0,P
            i_cnt = i_cnt+1
            if (i_cnt /= i_arr(1,1)[co_i,co_j,co_k]) then
               print * , "Error is cosubscript translation "
               print * , "[", co_i,",",co_j,",",co_k,"]/=",i_cnt
               is_err=1
            end if
           end do
         end do
      end do

      ! for the last value of the last dimension
      do co_j = -1,Q
        do co_i = 0,P
         i_cnt = i_cnt+1
         if (i_cnt .le. NPROCS) then
           if (i_cnt /= i_arr(1,1)[co_i,co_j,co_k]) then
              print * , "Error is cosubscript translation "
              print * , "[", co_i,",",co_j,",",dim3_max,"]/=",i_cnt
              is_err=1
           end if
         end if
        end do
      end do


      ! ************** REAL SCALAR ***********
      ! testing for coindexed r_scalar
       r_cnt = 0.0
       do co_k =1, dim3_max - 1
         do co_j = 1,N
           do co_i = 1,M
            r_cnt = r_cnt+1
            if (r_cnt /= r_sca[co_i,co_j,co_k]) then
               print * , "Error is cosubscript translation "
               print * , "[", co_i,",",co_j,",",co_k,"]/=",r_cnt
               is_err=1
            end if
           end do
         end do
      end do

      ! for the last value of the last dimension
      do co_j = 1,N
        do co_i = 1,M
         r_cnt = r_cnt+1
         if (r_cnt .le. NPROCS) then
           if (r_cnt /= r_sca[co_i,co_j,co_k]) then
              print * , "Error is cosubscript translation "
              print * , "[", co_i,",",co_j,",",dim3_max,"]/=",r_cnt
              is_err=1
           end if
         end if
        end do
      end do


      ! *********** REAL ARRAY ****************
      ! testing for allocatable coindexed r_array
      r_cnt = 0.0
      do co_k =1, dim3_max - 1
         do co_j = -1,Q
           do co_i = 0,P
            r_cnt = r_cnt+1
            if (r_cnt /= r_arr(1,1)[co_i,co_j,co_k]) then
               print * , "Error is cosubscript translation "
               print * , "[", co_i,",",co_j,",",co_k,"]/=",r_cnt
               is_err=1
            end if
           end do
         end do
      end do

      ! for the last value of the last dimension
      do co_j = -1,Q
        do co_i = 0,P
         r_cnt = r_cnt+1
         if (r_cnt .le. NPROCS) then
           if (r_cnt /= r_arr(1,1)[co_i,co_j,co_k]) then
              print * , "Error is cosubscript translation "
              print * , "[", co_i,",",co_j,",",dim3_max,"]/=",r_cnt
              is_err=1
           end if
         end if
        end do
      end do



      if (is_err /= 0) then
           STOP 1
      end if

      end program

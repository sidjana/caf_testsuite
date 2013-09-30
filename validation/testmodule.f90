
      module cross_test

      IMPLICIT NONE
      integer :: cross_err[*]

      contains

       subroutine calc_ori(cross_err)
          integer:: cross_err[*]
          if (cross_err .gt. 0) then
            STOP 1
          end if
       end subroutine

       subroutine calc (cross_err,tot_NITER)
          integer :: cross_err[*],tot_NITER, err_cnt
          integer :: size, rank, i
          integer :: percent=0
	  real :: mean,sumsq, sqsum, std_dev, root_size,ub,lb,n_size,t_val
	  real , allocatable :: mat(:,:)
	  character(len=30) :: bound_str
	  character(len=100) :: cmd_str

          size =  num_images()
          rank = this_image()
	  err_cnt = cross_err[1]
	  n_size=tot_NITER

          if (rank == 1) then
	  ! Some experimental confidence interval calculations using t-table 
	  !  if (tot_NITER<=30) then
	  !      allocate(mat(30,1))
	  !       open(unit=1, file='../support/t_table_95conf', status='OLD', action='READ')
	  !          read(1, *) mat
	  !          close(1)
	  !          t_val=mat(tot_NITER-1,1)
	  !  else
	  !      t_val=1.96
	  !  endif
          !   percent=(err_cnt*100.0)/tot_NITER
	  !   mean=err_cnt/tot_NITER
	  !   sumsq=err_cnt
	  !   sqsum=tot_NITER*mean*mean
	  !   std_dev=sqrt(sumsq-sqsum)/(tot_NITER-1)
	  !   root_size=sqrt(n_size)
	  !   lb=(mean+(t_val*std_dev/root_size))*100
	  !   if (lb>100.0) then
	  !   	lb=100.0
	  !   endif
	  !   ub=(mean-(t_val*std_dev/root_size))*100
	  !   if (ub>100.0) then
	  !   	ub=100.0
	  !   endif
	  !   lb=100-lb
	  !   ub=100-ub

	  !   write(bound_str,"(F6.3,A,F6.3,A)") lb,"% to ", ub,"%"
	     write(bound_str,"(A,I6,A,I6)") "Passed:", err_cnt,"/",tot_NITER
	     write(cmd_str,"(A,A,A)") "echo ",trim(adjustl(bound_str))," > conf.temp"
	     call system(cmd_str)
             call  exit(2)
          endif

       end subroutine calc


      end module cross_test

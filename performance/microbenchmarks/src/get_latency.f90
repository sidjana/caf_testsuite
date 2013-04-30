
!---------------------------------------------------------------------
!
!  This program is Latency and Bandwidth benchmarks with CAF put 
!  statement.
!
!  For the output files you need to specify : 
!      the path, 
!      the communication layer,
!      the cluster name,
!      cores number and processes number respectively.
!
!
!
!  Name                Date            Notes
!  --------------      ----------      --------------------
!  Asma Farjallah      July 2010       Init
!  Debjyoti Majumder   July 2011       Minor modifications
!
!---------------------------------------------------------------------

program get_latency

  implicit none

  integer,parameter :: iterations=10*NITER

  integer,allocatable:: msg(:)[:]
  integer           :: me
  integer           :: msg_size
  integer           :: i,k,it
  integer           :: ierr

  real(kind=8)      :: r_msgsize,r_iterations

  integer(kind=8)   :: srtc,ertc,res
  real(kind=8)      :: rtc,rtmp

  character(len=512):: output
  character(len=256) :: suffix,path
  character(len=64) :: layer,cluster,ncore,nproc

  allocate(msg(1)[*])

  me=this_image()

  call getarg(1,path)
  call getarg(2,layer)
  call getarg(3,cluster)
  call getarg(4,ncore)
  call getarg(5,nproc)

  suffix=trim(layer)//"_"//trim(cluster)//&
       "_NC"//trim(ncore)//"_NP"//trim(nproc)//".dat"

  output=trim(path)//"/get-latency_CAF_"//suffix

  if (me == 2) then
     !open(unit=10,file=trim(output),form='formatted',&
     !     status='replace',access='sequential',          &
     !     action='write',iostat=ierr                     )
     write(*,'(A1,A10,A20)') "#","[Bytes]","[Microsec]"

  endif

  i=1
  msg(1)=me
  msg_size=1

 sync all

 if (me == 2) then

    write(*,'(I2)',advance='no') i

    call get_rtc(srtc)

    do it=1,iterations
       msg(1:1)=msg(1:1)[1]
    enddo

    call get_rtc(ertc)
    call get_rtc_res(res)
    rtmp=res
    rtc=(ertc-srtc)/rtmp

    r_msgsize=msg_size
    r_iterations=iterations

    write(*,'(I10,E20.8)') 4,rtc*1000000.0/r_iterations

 endif

 sync all

 if (me == 2) then

   if (msg(1) /= 1) then
      write(*,*) "Data received is incomplete."
      call EXIT(1)
   endif

 endif

 deallocate(msg)

 !if (me == 2) then
 !   close(unit=10,iostat=ierr)
 !endif

end program GET_latency

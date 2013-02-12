      ! SORT INTEGER USING MULTIPLE IMAGES
      !
      ! This program uses coarray of integer and sorts the array.
      ! Each image does an insertion sort to sort the task distributed
      ! to it. (Other sorts can be used for improvement).
      ! When each image has sorted chunks, they are merged in O(log n) time

      program customerdb
        implicit none
        integer :: totalCount = 100000
        integer :: customers(100000)[*]
        integer, allocatable :: work1(:), work2(:)
        integer :: width, width1, width2, cw1, cw2, r
        integer :: startIndex[*], endIndex[*], palSIndex, palEIndex
        integer :: n=0, st, i, j, k, me, mypal, dim, rand_seed
        integer :: mylog2, find_mypal
        integer :: time_array(8)
        real :: start_time, end_time, diff, rand_num

        !allocate(customers(totalCount)[*])
        me = this_image()
        if (me == 1) then
            ! create random set of data for test sort
            do i=1,totalCount
                rand_seed = i
                call random_seed(rand_seed)
                call random_number(rand_num)
                customers(i) = int(rand_num*totalCount+1)
            end do
            ! distribute data set to other images
            do i=2, num_images()
                customers(:)[i] = customers
            end do
        end if

        sync all

        ! start timer after task is being divided
        call date_and_time(values=time_array)
        start_time = time_array(5) * 60 * 60 + time_array(6) * 60 &
            + time_array(7) + 0.001 * time_array(8)

        ! divide task
        call distribute_chunks(me, totalCount, startIndex, endIndex)
        !write (*, 1001) (customers(i), i=startIndex,endIndex)

        ! sort chunk
        call sort(customers,totalCount,startIndex,endIndex)

        ! merge results
        dim = mylog2(num_images())
        if (dim .ne. 0) then
            do i=1, dim
                mypal = find_mypal(me,i)
                if (mypal .gt. num_images()) then
                    cycle
                end if

                sync images(mypal)
                palSIndex = startIndex[mypal]
                palEIndex = endIndex[mypal]
                width1 = palEIndex - palSIndex + 1 ! plus 1 for inclusive
                allocate(work1(width1))
                work1 (1:width1) = customers(palSIndex:palEIndex)[mypal]

                width2 = endIndex - startIndex + 1 ! plus 1 for inclusive
                allocate(work2(width2))
                work2 (1:width2) = customers(startIndex:endIndex)

                ! merge between work1 and work2
                startIndex = min(startIndex, palSIndex)
                endIndex = max(endIndex, palEIndex)
                width = endIndex - startIndex + 1 ! plus 1 for inclusive
                cw1 = 1
                cw2 = 1
                r = startIndex
                do j = 1, width
                    if (cw1 .gt. width1) then
                        do k=cw2, width2
                            customers(r) = work2(cw2)
                            r = r + 1
                            cw2 = cw2 + 1
                        end do
                        exit
                    end if

                    if (cw2 .gt. width2) then
                        do k=cw1, width1
                            customers(r) = work1(cw1)
                            r = r + 1
                            cw1 = cw1 + 1
                        end do
                        exit
                    end if

                    if (work1(cw1) < work2(cw2)) then
                        customers(r) = work1(cw1)
                        cw1 = cw1 + 1
                    else
                        customers(r) = work2(cw2)
                        cw2 = cw2 + 1
                    end if

                    r = r + 1

                end do
                !if (me == 1) then
                    !print *, 'width1, width2, width : ', width1, width2, width
                    !write (*, 1001)  (work1(k), k=1, width1)
                    !print *, '--------------'
                    !write (*, 1001) (work2(k), k=1, width2)
                    !print *, '--------------'
                !end if
                deallocate(work1)
                deallocate(work2)
                sync images (mypal)
            end do
        end if

        call date_and_time(values=time_array)
        end_time = time_array(5) * 60 * 60 + time_array(6) * 60 &
            + time_array(7) + 0.001 * time_array(8)
        diff = end_time - start_time

        if (me == 1) then
            print *, "Sorting Integer on array size ", totalCount
            print *, "Image: ", me, ", Time taken:", diff, "s"
        end if
      end program customerdb

      subroutine distribute_chunks(me, total, sIndex, eIndex)
        integer, intent(in) :: me, total
        integer, intent(out) :: sIndex, eIndex
        integer :: width

        width = ceiling(real(total)/num_images())
        sIndex = (me-1)*width + 1
        eIndex = sIndex + width - 1
        if (eIndex .gt. total) then
            eIndex = total
        end if
        !print *, me, width, sIndex, eIndex
      end subroutine

      subroutine sort(customerList,t,startIndex,endIndex)
        implicit none
        integer, intent(in) :: startIndex, endIndex, t
        integer, dimension(t), intent(inout) :: customerList[*]
        integer :: temp
        integer :: i,j,m

        do i=startIndex, endIndex-1
            m = i
            do j=i+1,endIndex
                if (customerList(j) .lt. customerList(m)) then
                    m = j
                end if
            end do

            if (m /= i) then
                temp = customerList(i)
                customerList(i) = customerList(m)
                customerList(m) = temp
            end if
        end do
      end subroutine sort

      function mylog2(n) result(l)
        integer :: l
        integer, intent(in) :: n
        l = ceiling(log(real(n))/log(2.))
      end function mylog2

      function find_mypal(img, iter) result(l)
        integer :: l, denominator, hop
        integer, intent(in) :: img, iter

        denominator = 2**iter
        hop = 2**(iter-1)
        offset = mod(img, denominator)

        ! wrap around the offset so that lowest image number
        ! will have offset 0 and highest image number will have
        ! offset equal to denominator. Then less 1 to make it start
        ! from zero
        ! e.g. iter 1 can cause offsets 1,2
        !      iter 2 can cause offsets 0,1,2,3
        if (offset .eq. 0) then
            offset = denominator
        end if
        offset = offset -1

        if (offset < denominator/2) then
            l = img + hop
        else
            l = img - hop
        end if
        !print *,iter,img,l,'hop: ',hop,'deno: ',denominator,'off: ',offset
      end function find_mypal


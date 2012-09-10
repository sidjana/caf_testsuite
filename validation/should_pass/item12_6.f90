! this program is taken from Reid's paper N1824

      program item12_6

            use, intrinsic :: iso_fortran_env
            logical(atomic_logical_kind) :: locked[*] = .true.
            logical :: val
            integer :: iam, p, q

            iam = this_image()

            if (iam == p) then
              sync memory
              call atomic_define(locked[q],.false.)
              ! Has the effect of locked[q]=.false.
            else if (iam == q) then
              val = .true.
              ! Spin until val is false
              do while (val)
                 call atomic_ref(val,locked)
                 ! Has the effect of val=locked
              end do
              sync memory
            end if

      end program

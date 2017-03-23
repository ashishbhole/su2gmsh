      program main
      use variables
      implicit none
      integer :: i, status = 0
      character(len=32) :: arg, dmnsn
      logical exist 

      do i = 1, iargc()
         call get_command_argument(i, arg)
         if(i==1)then
            dmnsn = arg
            if((dmnsn .ne. '2') .and. (dmnsn .ne. '3'))then
               print*, 'Enter valid dimensions'
               call exit(status)
            endif
         elseif(i==2)then
            su2filename  = arg
            su2filename  = trim(su2filename) // '.su2'
            inquire(file=su2filename, exist=exist)
            if(exist)then
            else
               print*, 'Enter correct su2 filename without extension:'
               call exit(status)
            endif
            gmshfilename = arg
            gmshfilename = trim(gmshfilename) // '.msh'
         endif
      enddo

      if(dmnsn == '2')then
         call read_su2_2d
         call write_gmsh_2d
      elseif(dmnsn == '3')then
         call read_su2_3d
         call write_gmsh_3d
      else
         write(*,*) 'Enter valid no of dimensions'
      endif

      end program main

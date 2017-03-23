      subroutine write_gmsh_2d

      use variables
      implicit none
      integer :: i

      print*, "!------------------------------------------"
      print*, "Writing 2D gmsh grid file"

      open(10,file=trim(gmshfilename))

      write(10,'(A11)')"$MeshFormat"
      write(10,'(A8)')"2.2 0 8"
      write(10,'(A14)')"$EndMeshFormat"
      write(10,'(A6)')"$Nodes"
      write(10, '(I8)') nv        ! no of vertices
      do i = 1, nv
         write(10,'(I8,1X,3F20.14)') i, coord(1:2,i), 0.0d0  ! coordinates of each vertex
      enddo
      write(10,'(A9)')"$EndNodes"
      write(10,'(A9)')"$Elements"
      write(10, *) nbf+nc      ! no of elements (faces + cells)
      do i=1,nbf
         write(10,*) i, tface(i), 2, btag(i), btag(i), bface(1:nve(tface(i)),i)
      enddo
      do i=1,nc
         write(10,*) nbf+i, tcell(i), 2, 1, 1, cell(1:nve(tcell(i)),i)
      enddo
      write(10,'(A12)')"$EndElements"
      close(10)

      print*, "Finished writing 2D gmsh grid file"
      print*, "!------------------------------------------"

      end subroutine write_gmsh_2d

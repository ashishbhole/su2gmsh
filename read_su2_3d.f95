      subroutine read_su2_3d

      use variables
      implicit none
      integer :: i, j, k, m, ntet, nhex, npri, npyr

      print*, "!------------------------------------------"
      print*, "Reading 3D grid from SU2 file"

      open(10,file=trim(su2filename),status='old')

      read(10, *) string, ndime        ! no of dimensions
      if(string .ne. "NDIME=")then
          print*,"Error reading su2 grid file"
      endif
      if(ndime .ne. 3)then
          print*,"Error: Grid must be 3-Dimensional"
      endif

      read(10, *) string, nc        ! no of cells
      if(string .ne. "NELEM=")then
          print*,"Error reading su2 grid file"
      endif

      ntet = 0; nhex = 0; npri = 0; npyr = 0
      allocate(tcell(1:nc), cell(1:8, 1:nc), list(1:8))
      do i = 1, nc

         read(10,*) sutype, (list(j), j=1,nvcsu2(sutype))
         cell(1:nvcsu2(sutype),i) = list(1:nvcsu2(sutype))+1   ! to compensate starting from zero

         if(sutype .eq. 10)then  ! tet
            tcell(i) = 4
            ntet = ntet+1
         elseif(sutype .eq. 12)then ! hex
            tcell(i) = 5
            nhex = nhex+1
         elseif(sutype .eq. 13)then ! prism
            tcell(i) = 6
            npri = npri+1
         elseif(sutype .eq. 14)then ! pyramid
            tcell(i) = 7
            npyr = npyr+1
         else
            print*, "Error: Invalid cell type in su2 file"
         endif
      enddo

      print*, " No of tetrahedrons         : ", ntet
      print*, " No of prisms               : ", npri
      print*, " No of pyramids             : ", npyr
      print*, " No of hexagons             : ", nhex
      print*, " Total no of cells          : ", nc

      read(10, *) string, nv        ! no of vertices
      if(string .ne. "NPOIN=")then
          print*,"Error reading su2 grid file"
      endif
      allocate(coord(1:3,1:nv))
      do i = 1, nv
         read(10,*) coord(1:3,i), j
      enddo

      read(10, *) string, nmark        ! no of boundary markers
      if(string .ne. "NMARK=")then
          print*,"Error reading su2 grid file"
      endif

      allocate(btag(1:8*nc), tface(1:8*nc), bface(1:4,1:8*nc))

      i = 0; m = 0
      DO k = 1, nmark
         read(10, *) string, boundary_marker
         read(10, *) string, nfac

         do j = 1, nfac
            read(10,*) sutype, (list(m), m=1,nvcsu2(sutype))
            i = i + 1
            bface(1:nvcsu2(sutype),i) = list(1:nvcsu2(sutype))+1   ! to compensate starting from zero

            if(sutype .eq. 5)then  ! tet
               tface(i) = 2
            elseif(sutype .eq. 9)then ! hex
               tface(i) = 3
            else
               print*, "Error: Invalid face type in su2 file"
            endif
            if(trim(boundary_marker) .eq. "PER1")then
               btag(i) = 100
            elseif(trim(boundary_marker) .eq. "PER2")then
               btag(i) = 200
            elseif(trim(boundary_marker) .eq. "PER3")then
               btag(i) = 300
            elseif(trim(boundary_marker) .eq. "PER4")then
               btag(i) = 400
            elseif(trim(boundary_marker) .eq. "PER5")then
               btag(i) = 500
            elseif(trim(boundary_marker) .eq. "PER6")then
               btag(i) = 600
            elseif(trim(boundary_marker) .eq. "WING")then
               btag(i) = 200001
            elseif(trim(boundary_marker) .eq. "FARF")then
               btag(i) = 102
            elseif(trim(boundary_marker) .eq. "SYMM")then
               btag(i) = 200002
            endif
         enddo
         nbf = i   ! total no of boundary faces
      ENDDO
      close(10)

      print*, "Reading su2 3D grid file finished"
      print*, "!------------------------------------------"

      end subroutine read_su2_3d

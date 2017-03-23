      subroutine read_su2_2d

      use variables
      implicit none
      integer :: i, j, k, m, ntri, nquad

      print*, "!------------------------------------------"
      print*, "Reading 2D grid from SU2 file"

      open(10,file=trim(su2filename),status='old')

      read(10, *) string, ndime        ! no of dimensions
      if(string .ne. "NDIME=")then
          print*,"Error reading su2 grid file"
      endif
      if(ndime .ne. 2)then
          print*,"Error: Grid must be 2-Dimensional"
      endif

      read(10, *) string, nc        ! no of cells
      if(string .ne. "NELEM=")then
          print*,"Error reading 2D su2 grid file"
      endif

      ntri = 0; nquad = 0
      allocate(tcell(1:nc), cell(1:8,1:nc), list(1:8))
      do i = 1, nc

         read(10,*) sutype, (list(j), j=1,nvcsu2(sutype))
         cell(1:nvcsu2(sutype),i) = list(1:nvcsu2(sutype))+1   ! to compensate starting from zero

         if(sutype .eq. 5)then  ! tri
            tcell(i) = 2
            ntri = ntri+1
         elseif(sutype .eq. 9)then ! hex
            tcell(i) = 3
            nquad = nquad+1
         else
            print*, "Error: Invalid cell type in su2 file"
         endif
      enddo

      print*, " No of triangles           : ", ntri
      print*, " No of quadrilaterals      : ", nquad
      print*, " Total no of cells         : ", nc

      read(10, *) string, nv        ! no of vertices
      if(string .ne. "NPOIN=")then
          print*,"Error reading su2 grid file"
      endif
      allocate(coord(1:2,1:nv))
      do i = 1, nv
         read(10,*) coord(1:2,i), j
      enddo

      read(10, *) string, nmark        ! no of boundary markers
      if(string .ne. "NMARK=")then
          print*,"Error reading 2D su2 grid file"
      endif

      allocate(btag(1:4*nc), tface(1:4*nc), bface(1:4,1:4*nc))

      i = 0; m = 0
      DO k = 1, nmark
         read(10, *) string, boundary_marker
         read(10, *) string, nfac

         do j = 1, nfac
            read(10,*) sutype, (list(m), m=1,nvcsu2(sutype))
            i = i + 1
            bface(1:nvcsu2(sutype),i) = list(1:nvcsu2(sutype))+1   ! to compensate starting from zero

            if(sutype .eq. 3)then  ! line
               tface(i) = 1
            else
               print*, "Error: Invalid face type in 2D su2 file"
            endif
            if(trim(boundary_marker) .eq. "PER1")then
               btag(i) = 101
            elseif(trim(boundary_marker) .eq. "PER2")then
               btag(i) = 102
            elseif(trim(boundary_marker) .eq. "PER3")then
               btag(i) = 201
            elseif(trim(boundary_marker) .eq. "PER4")then
               btag(i) = 202
            elseif(trim(boundary_marker) .eq. "inlet")then
               btag(i) = 100
            elseif(trim(boundary_marker) .eq. "outlet")then
               btag(i) = 200
            elseif(trim(boundary_marker) .eq. "farfield")then
               btag(i) = 300
            elseif(trim(boundary_marker) .eq. "symmetry")then
               btag(i) = 400
            elseif(trim(boundary_marker) .eq. "wall")then
               btag(i) = 500
            endif
         enddo
         nbf = i   ! total no of boundary faces
      ENDDO
      close(10)

      print*, "Reading 2D su2 grid file finished"
      print*, "!------------------------------------------"

      end subroutine read_su2_2d

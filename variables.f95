      module variables
      implicit none

!     no of edges per elements: tri, quad, tet, hex, prism, pyramid
      integer :: nve(7) 
      data nve/2, 3, 4, 4, 8, 6, 5/

!     no of vertices per cells in su2 type grid
      integer :: nvcsu2(14)
      data nvcsu2/0, 0, 2, 0, 3, 0, 0, 0, 4, 4, 0, 8, 6, 5/

!     no of vertices, cells, boundary faces, element
      integer nv, nc, nbf, nelem, ndime

!     coordinates of vertices
      double precision, allocatable    ::  coord(:,:)

!     nodes of cells, boundary faces and help data structure for boundary face
      integer, allocatable ::  cell(:,:), bface(:,:), btag(:)

!     types of cell, boundary faces, elements
      integer, allocatable :: tcell(:), tface(:)

!     any string, file name of gmsh file
      CHARACTER(LEN=256) :: gmshfilename, su2filename

!     type of elements in su2 format, no of markers in su2 format, no of faces in each marker
      integer :: sutype, nmark, nfac

      integer, allocatable :: marker(:), list(:)
      character (len=256) :: string, boundary_marker

      end module variables

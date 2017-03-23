This code converts 2d/3d mesh in su2 format into 2d/3d msh format.

To run this code:
1) Copy or move su2 file to be converted into su2gmsh directory.

2) make

3) ./su2gmsh dim su3filename_without_extension
   -- where dim --> dimension of grid (2 or 3)
         
Shortcomings/ Possible Improvements:
Boundary tags are in the form of strings in su2 file.
Source code may have to modify to account for string 
tags and generate respective gmsh integer tags.

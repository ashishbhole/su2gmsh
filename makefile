FC = gfortran
FFLAGS = -O3 -fdefault-real-8

TARGETS = su2gmsh

ALL: $(TARGETS)

SRC = $(wildcard *.f95)
OBJ = $(patsubst %.f95,%.o,$(SRC))

su2gmsh: $(OBJ)
	$(FC) -o su2gmsh $(OBJ)

variables.mod: variables.f95
	$(FC) -c $(FFLAGS) variables.f95

%.o: %.f95 variables.mod
	$(FC) -c $(FFLAGS) $*.f95

clean:
	rm -f $(OBJ) $(TARGETS) *.mod

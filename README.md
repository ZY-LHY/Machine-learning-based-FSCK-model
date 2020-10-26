# Machine-learning-based-FSCK-model
================================================================================================
Instructions (The machine learning based FSCK model): 
!---The program is used to calculate k-distributions (32 GaussâChebyshev quadrature points) 
!---The thermodynamic states for the gas mixture profiles can be changed in "Main.f90":

1) Clean up
command: make clean

2) Compile the Fortran program
command: make

3) Calculate the radiative heat loss with the machine learning based FSCK model (1-D exact+FSCK):
command:   ./rhs 

4) Plot the results
command: python plot.py
================================================================================================
Compulsory libraries
====================
GNU Fortran

# Machine learning based FSCK model

# Abstract:
The full-spectrum correlated-k-distribution (FSCK) look-up table previously developed by Wang et al.(2018) provides an efficient means for accurate calculations of radiative properties in nonhomogeneous media, which was constructed for gas mixtures of three species, i.e., CO2, CO and H2O within a large range of thermodynamic states. However, the total size of the FSCK look-up table is about 3.2 GB. In order to obtain accurate k-values for arbitrary thermodynamic states from the tabulated values, a 6-D linear interpolation method has to be employed. In practical applications, transferring and loading such a huge database are inconvenient and time-consuming. In this study, we presented a machine learning approach to accurately fit the FSCK look-up table, in order to provide an efficient and compact FSCK model. Without interpolation on the fly, correct k-distributions for any arbitrary thermodynamic states can be obtained directly and the total size of the trained machine learning model is only about 35 MB.

# Dependencies
Compulsory libraries

GNU Fortran

Python

# Quick Start
Instructions (The machine learning based FSCK model): 

!-The program is used to calculate k-distributions (32 Gaussa Chebyshev quadrature points) 

!-The thermodynamic states for the gas mixture profiles can be changed in "Main.f90":

1) Clean up

command: make clean

2) Compile the Fortran program

command: make

3) Get the k-distributions:

command:   ./rhs 

4) Plot the results

command: python plot.py

# Citation
If you used this package in your research and is interested in citing it here's how you do it:

@article{ML:Zwr20,

title = "A machine learning based efficient and compact full-spectrum correlated $k$-distribution model",

journal = "Journal of Quantitative Spectroscopy and Radiative Transfer",

volume = "254",

pages = "107199",

year = "2020",

author = "Ya Zhou and Chaojun Wang and Tao Ren",

}

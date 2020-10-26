!---The program is used to calculate k-distributions (32 GaussâChebyshev quadrature points) 
!---Pressure: 0.1 bar ~ 80 bar
!---Temperature: recommended 300 K ~ 3000 K
!---Species: CO2 or H2O or CO or the mixture of CO2&H2O&CO
PROGRAM OneDimensionExact
!--------------------------------------------------------------------------------
use commonData, only : GasMixInfo
use MLP
use commonData, only : GasMixInfo
IMPLICIT NONE
!--------------------------------------------------------------------------------
  integer,parameter :: Nq=32
  real(8):: Tref ! reference temperature
  real(8),dimension(Nq) :: k ! k-values
  TYPE(GasMixInfo) :: locMix_f        ! Local mixture information
  OPEN(UNIT=32, FILE='results/k_new.dat', STATUS='REPLACE') ! new k-distributions
!--------------------------------------------------------------------------------
  locMix_f%p=37.50d0
  locMix_f%T=1050.0d0
  Tref=1650.0d0
  locMix_f%xCO2=0.375d0
  locMix_f%xH2O= 0.375d0 
  locMix_f%xCO=0.075d0
!~~~~~~~~~
  ! get k-values
  if (locMix_f%P<=1) then 
    call get_k_mlp_1(locMix_f,Tref,k) 
!~~~~~~~~~
  else if (locMix_f%P>1) then       
    call get_k_mlp_2(locMix_f,Tref,k) 
  end if
!~~~~~~~~~
  write(32,*) k
  write(*,*)k
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
END PROGRAM OneDimensionExact
!--------------------------------------------------------------------------------
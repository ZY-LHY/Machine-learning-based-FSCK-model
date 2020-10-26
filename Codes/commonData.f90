!!$**********************************************************************************
!!$                   SPECTRAL RADIATION CALCULATION SOFTWARE ~ SRCS ~
!!$**********************************************************************************
!!$
!!$                     COPYRIGHT (C) 2013 MICHAEL F. MODEST
!!$
!!$                           SCHOOL OF ENGINEERING                      
!!$                      UNIVERSITY OF CALIFORNIA AT MERCED
!!$
!!$	License: 
!!$		This file is a part of SRCS.
!!$		Used for non-commercial purposes only.
!!$		Not to be distributed without the permission of the copyright holder
!!$
!!$**********************************************************************************
!************************************************************************************************************************
! Module containing common data for all methods and databases
!************************************************************************************************************************
MODULE commonData

IMPLICIT NONE

SAVE

!=========================================LBL COMMON DATA=================================================================
INTEGER,PARAMETER,PUBLIC :: iSOOT=0,CO2=1,H2O=2,CO=3,CH4=4,C2H4=5
TYPE GasInfo
  INTEGER :: Gas
  REAL(8) :: P,T,x
END TYPE GasInfo
REAL(8),PARAMETER,PUBLIC :: pwr= 0.1d0

LOGICAL,PUBLIC            :: Pressure_based= .FALSE.            ! linear or pressure-based Planck mean absco
REAL(8),PARAMETER,PUBLIC  :: wvnm_b=200.0d0,wvnm_e=15000.0d0    ! wavenumber range for nbk-dists(must adjust
INTEGER,PARAMETER,PUBLIC  :: n_pwrk= 5000 ! number of k-g points from lbl 
REAL(8),PARAMETER,PUBLIC  :: wvnmst=1.0d-2 ! wvnmstep for user specification

!=========================================================================================================================

!======================================k-distribution method identifiers==================================================
INTEGER,PARAMETER,PUBLIC :: FSK=1,NB_FSK=2,MSFSK=3,NB_MSFSK=4,MGFSK=5,NB_MGFSK=6,MSMGFSK=7,NB_MSMGFSK=8
!========================================================================================================================

!=========================================kp file data====================================================================
INTEGER,PUBLIC :: ndata=126 ! number of data in Planck mean absco database
!=========================================================================================================================

!==================================GENERAL DB PARAMETERS==================================================================
! database identifiers
INTEGER,PARAMETER,PUBLIC :: FSMGDB=1,NBSGDB=2,NBMGDB=3

TYPE GasMixInfo
  REAL(8)  :: P,T  ! Gas properties
  REAL(8)  :: xCO2,xH2O,xCO,xCH4,xC2H4  ! species mole fraction (more can be added)
  REAL(8)  :: fv  ! soot volume fraction
END TYPE GasMixInfo

!!$ database k-g distribution species id
INTEGER,PARAMETER,PUBLIC  :: kg_CO2=1,kg_H2O=2,kg_CO=3,kg_CH4=4,kg_C2H4=5
INTEGER,PARAMETER,PUBLIC  :: spDB=5   ! number of species having k-g database

! number of points in k-g databases
INTEGER,PUBLIC,PARAMETER :: Ndb= 257, NoP=128, nfxk= 64, NNU=248

! number of groups in k-g distribution files
INTEGER,PUBLIC,PARAMETER :: Ng=4

INTEGER,PARAMETER,PUBLIC  :: imLinear= 0, im3DSpline= 7, im1Dspline= 2, im2Dspline=6, im4DLinear=0 
! 0--B'000', 7--B'111', 2--B'010', 6--B'0110'
!bitwise description of Interp_Method (except im2Dspline): (B3 B2 B1)  1 -- spline, 0 -- linear. B3: P, B2: T, B1: x.
!bitwise description of im2Dspline, im4DLinear: (B4 B3 B2 B1)  1 -- spline, 0 -- linear. B4: P, B3: T, B2: Tp, B1: x.

REAL(8),PUBLIC :: kg_nb_Low(NNU),kg_nb_High(NNU) 

!=========================================================================================================================

!================================NB SG DATA RETREIVAL PARAMETERS==========================================================
! data structure of index file record
! ****(MAY NEED MODIFICATION)###########
TYPE NBSGIndexRec
  INTEGER(KIND=4):: kgRecNum    ! k-g data record in which a certain k-g distribution is contained
  INTEGER(KIND=2):: offset      ! offset inside the k-g data record
  INTEGER(KIND=2):: NoP         ! the number of points included in a certain k-g distribution
  REAL(KIND=4)   :: kmax        ! the maximum value of the k-g distribution
END TYPE NBSGIndexRec  

! data structure of memory index record
TYPE NBSGIndexMemRec
  INTEGER(KIND=4):: offset
  INTEGER(KIND=2):: NoP
  REAL(KIND=4)   :: kmax
END TYPE NBSGIndexMemRec

! data structure of a narrow band information
TYPE NBSGkgInfo
  INTEGER(KIND=2):: NB          ! narrow band number. 1 <= NB <= 248
  INTEGER(KIND=2):: Gas         ! species
  REAL(KIND=8)   :: P           ! total pressure
  REAL(KIND=8)   :: T           ! temperature
  REAL(KIND=8)   :: x           ! mole fraction
END TYPE NBSGkgInfo

!=========================================================================================================================

!============================NB MG DATA RETREIVAL PARAMETERS==============================================================
! data structure of index file record
TYPE NBMGIndexRec
  INTEGER(KIND=4):: kgRecNum    ! k-g data record in which a certain k-g distribution is contained
  INTEGER(KIND=2):: offset      ! offset inside the k-g data record
  INTEGER(KIND=2):: NoP         ! the number of points included in a certain k-g distribution
  REAL(KIND=4)   :: kmax        ! the maximum value of the k-g distribution
  REAL(KIND=4)   :: gmin        ! minimum g for each group within each NB
END TYPE NBMGIndexRec  

! data structure of memory index record
TYPE NBMGIndexMemRec
  INTEGER(KIND=4):: offset
  INTEGER(KIND=2):: NoP
  REAL(KIND=4)   :: kmax
  REAL(KIND=4)   :: gmin
END TYPE NBMGIndexMemRec

! data structure of a narrow band information
TYPE NBMGkgInfo
  INTEGER(KIND=2):: NB          ! narrow band number. 1 <= NB <= 248
  INTEGER(KIND=2):: GP          ! groups (=4) for each NB
  INTEGER(KIND=2):: Gas         ! species
  REAL(KIND=8)   :: P           ! total pressure
  REAL(KIND=8)   :: T           ! temperature
  REAL(KIND=8)   :: x           ! mole fraction
END TYPE NBMGkgInfo
!===========================================================================================================================

!============================FS MG DATA RETREIVAL PARAMETERS==============================================================
! data structure of index file record
TYPE FSMGIndexRec
  INTEGER(KIND=4):: kgRecNum    ! k-g data record in which a certain k-g distribution is contained
  INTEGER(KIND=2):: offset      ! offset inside the k-g data record
  INTEGER(KIND=2):: NoP         ! the number of points included in a certain k-g distribution
  REAL(KIND=4)   :: kmax        ! the maximum value of the k-g distribution
  REAL(KIND=4)   :: gmin        ! minimum g for each group
END TYPE FSMGIndexRec  

! data structure of memory index record
TYPE FSMGIndexMemRec
  INTEGER(KIND=4):: offset
  INTEGER(KIND=2):: NoP
  REAL(KIND=4)   :: kmax
  REAL(KIND=4)   :: gmin
END TYPE FSMGIndexMemRec

! data structure of a full-spectrum k-g information
TYPE FSMGkgInfo
  INTEGER(KIND=2):: GP          ! groups (=4) for each NB
  INTEGER(KIND=2):: Gas         ! species
  REAL(KIND=8)   :: P           ! total pressure
  REAL(KIND=8)   :: T           ! temperature
  REAL(KIND=8)   :: Tp          ! Planck function temperature
  REAL(KIND=8)   :: x           ! mole fraction
END TYPE FSMGkgInfo
!===========================================================================================================================


END MODULE commonData


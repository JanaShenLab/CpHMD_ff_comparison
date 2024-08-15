
########################################################
#  Important information                               #
########################################################

# Standard Variables
protein="$1"   # Name
phmdparm='ff19sb_pme.parm'  # CpHMD parm file; 
nres=7                      # penta peptide in charmm FF has 5 residues; change it to 7 for parameters of Amber FF.
stage=1           # stage for production; if stage =1, do all steps; if stage > 1, only restart production step 
cutoff=10.0       # Nonbond cutoff
                  # For GB, use 999.0 
                  # For CHARMM 22, use 12.0
                  # For Amber FF, use 9.0 ang for small system like penpta peptides, otherwise use 10.0 ang.

if [[ $protein = "asp" ]]
then
  phvalues=(2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5)
elif [[ $protein = "glu" ]]
then
  phvalues=(2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0)
elif [[ $protein = "his" ]]
then
  phvalues=(4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0)
elif [[ $protein = "cys" ]]
then
  phvalues=(7.0 7.5 8.0 8.5 9.0 9.5 10.0 10.5)
elif [[ $protein = "lys" ]]
then
  phvalues=(9.0 9.5 10.0 10.5 11.0 11.5 12.0 12.5)
elif [[ $protein = "tyr" ]]
then
  phvalues=(9.0 9.5 10.0 10.5 11.0 11.5 12.0 12.5)
else
  echo "Only asp, glu, his, cys, lys, and tyr are supported."
  exit
fi


####################
# Heating Specific #
####################
stemp=100         # Start temp for heating 
etemp=300        # End temp for heating 
hnsteps=25000    # 50 ps
hwfrq=500        # How often to write ene. vel. temp. and lamb.
hwrst=10000       # How often to write restart files
hts=0.002        # Time step
hrestraint=5.0   # Restrataint for heating


#########################################################################################################

###########
# Heating #
###########


echo "heating
&cntrl
  imin = 0, nstlim = $hnsteps, dt = $hts,                         ! Don't Minimize, Number of steps, time step
  irest = 0, ntx = 1, ig = -1,                                    ! Read vel. (1 = input, 0 = no restart), (1 = start from min, 2 = start from md), random number seed 
  tempi = $stemp, temp0 = $etemp,                                 ! Initial temp., Target Temp. 
  ntc = 2, ntf = 2, tol = 0.00001,                                ! Shake (2 = bonds involving hydrogen), Force Eval. 
  ntwx = $hwfrq, ntwe = $hwfrq, ntwr = $hwrst, ntpr = $hwfrq,      ! Print info 
  cut=$cutoff, fswitch=10, iwrap=0,                               ! cutoff, no wrap; for Amber FF, delete 'fswitch = 10.0,'
  ntt = 3, gamma_ln = 1.0, ntb = 1, ntp = 0,                      ! Choose temp. control (3 = langevin), Collision Frq,
  nscm = 0,                                                       ! Remove center of mass motion every nscm steps      
  ntr = 1, restraintmask = ':1-$nres&!@H=', restraint_wt = $hrestraint, ! All restraint options                    
  iphmd = 3, solvph = 7.5,                   ! 2 = hybrid, pH, Implicent salt concentration
  nmropt = 1,                                                     ! Change thermostat with time 
  ioutfm = 1, ntxo = 2,                                           ! Output type 
/
&wt
  TYPE=\"TEMP0\", istep1 = 0, istep2 = $hnsteps,                 ! This section modulates the heatup rate 
  value1=$stemp, value2=$etemp,
/
&wt
  TYPE=\"END\",
/" > pH${replicaph}_heating.mdin

pmemd.cuda -O -i pH${replicaph}_heating.mdin -c mini3.rst7 -p ${protein}.parm7 -ref mini3.rst7 -phmdin phmdin_start -phmdparm $phmdparm -phmdout pH${replicaph}_heating.lambda -phmdrestrt pH${replicaph}_heating.phmdrst -o pH${replicaph}_heating.mdout -r pH${replicaph}_heating.rst7 -x pH${replicaph}_heating.nc
########################################################
#  Important information                               #
########################################################

# 
protein="$1"                # system name; must be one of asp, glu, his, cys, lys, and tyr
                            # The parm7 file should be $protein.parm7 and the minimized structure is mini3.rst7
phmdparm='ff19sb_pme.parm'  # CpHMD parm file; 
nres=7                      # penta peptide in charmm FF has 5 residues; change it to 7 for parameters of Amber FF.
#

# Standard Variables
stemp=100         # Start temp for heating 
etemp=300        # End temp for heating 
itemp=50         # Temp to incrment the heating by 
crysph=7.0       # Starting pH, can come from cyrstal structure for protein 

cutoff=10.0       # Nonbond cutoff
                  # For GB, use 999.0 
                  # For CHARMM 22, use 12.0
                  # For Amber FF, use 9.0 ang for small system like penpta peptides, otherwise use 10.0 ang.

restraints=(2.0 1.0 0.0)   # Restraints for equilibration 

####################
# Heating Specific #
####################

hnsteps=25000    # 25000
hwfrq=250        # How often to write ene. vel. temp. and lamb.
hwrst=1000       # How often to write restart files
hts=0.002        # time step

##########################
# Equilibration Specific #
##########################

ensteps=50000    # 50000
ewfrq=250
ewrst=10000
ets=0.002

#######################
# Production Specific #
#######################

pnsteps=5000000    # 10ns by default; increase to 20ns if necessary.
pwfrq=500
pwrst=10000
pts=0.002

# Parameter arrays #---------------------------------
if [[ $protein = "lys" || $protein = "cys" || $protein = "tyr" ]]
then
  arrtheta=(0.4 0.6 0.7854 1.0 1.2) #
  # arrtheta=(0.0 0.2 0.4 0.6 0.7854 1.0 1.2 1.4 1.5708) is the real array, but dU/dlambda for 0.0 and 1.5708 are just 0.
  # To test whether the code runs properly, you can set arrtheta=(0.0 1.5708) and run for a short time to see whether the output
  # colomns only have 0s.
elif [[ $protein = "asp" || $protein = "glu" ]]
then
  arrtheta=(0.0 0.4 0.6 0.7854 1.0 1.2 1.4) #
  arrthetax=(0.4 0.6 0.7854 1.0 1.2 1.4)
  # arrthetax=(0.0 1.5708) #
  # arrtheta=(0.4 0.6 0.7854 1.0 1.2 1.4)
elif [[ $protein = "his" ]]
then
  arrtheta=(1.5708) #
  arrthetax=(0.2 0.4 0.6 0.7854 1.0 1.2 1.4)
  # arrthetax=(0.0 1.5708) #
  # arrtheta=(0.2 0.4 0.6 0.7854 1.0 1.2 1.4)
else
  echo "Only asp, glu, his, cys, lys, and tyr are supported."
  exit
fi
#----------------------------------------------------

##############
# Preparing  #
##############

echo "heating
&cntrl
  imin = 0, nstlim = $hnsteps, dt = $hts,                         ! Don't Minimize, Number of steps, time step
  irest = 0, ntx = 1, ig = -1,                                    ! Read vel. (1 = input, 0 = no restart), (1 = start from min, 2 = start from md), random number seed 
  tempi = $stemp, temp0 = $etemp,                                 ! Initial temp., Target Temp. 
  ntc = 2, ntf = 2, tol = 0.00001,                                ! Shake (2 = bonds involving hydrogen), Force Eval. 
  ntwx = $hwfrq, ntwe = $hwfrq, ntwr = $hwrst, ntpr = $hwfrq,     ! Print info 
  cut=$cutoff, fswitch = 10.0, iwrap=0,                           ! cutoff, no wrap, for Amber FF, delete 'fswitch = 10.0,'
  ntt = 3, gamma_ln = 1.0, ntb = 1, ntp = 0,                      ! Choose temp. control (3 = langevin), Collision Frq,
  nscm = 0,                                                       ! Remove center of mass motion every nscm steps      
  ntr = 1, restraintmask = ':1-$nres&!@H=', restraint_wt = 5.0,   ! All restraint options                    
  iphmd = 3, solvph = $crysph,                                    ! 2 = hybrid, pH, Implicent salt concentration
  nmropt = 1,                                                     ! Change thermostat with time 
  ioutfm = 1, ntxo = 2,                                           ! Output type 
 /
 &wt
   TYPE=\"TEMP0\", istep1 = 0, istep2 = $hnsteps,                 ! This section modulates the heatup rate 
   value1=$stemp, value2=$etemp,
/
&wt
  TYPE=\"END\",
/" > heating.mdin


for theta in ${arrtheta[@]}
do
  if [[ $protein = "lys" || $protein = "arg" || $protein = "cys" ]]
  then 
  echo "&phmdstrt
         ph_theta = $theta, 511*0.78539816339744828,
         vph_theta = 0.0, 511*0.78539816339744828,
  /" > phmdstrt_${theta}.in
  elif [[ $protein = "asp" || $protein = "glu" || $protein = "his" ]]
  then
    for thetx in ${arrthetax[@]}
    do 
    echo "&phmdstrt
            ph_theta = $theta,$thetx,510*0.78539816339744828,
            vph_theta = 0.0,0.0,510*0.78539816339744828,
         /" > phmdstrt_${theta}_${thetx}.in 
    done
  fi
done 

#################
# Heating       #
#################

j=0
for theta in ${arrtheta[@]}
do 
  if [[ $protein = "lys" || $protein = "arg" || $protein = "cys" ]]
  then 
    pmemd.cuda -O -i heating.mdin -c mini3.rst7 -p ${protein}.parm7 -ref mini3.rst7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout heating_${theta}.lambda -phmdstrt phmdstrt_${theta}.in -o heating_${theta}.mdout -r heating_${theta}.rst7 
  elif [[ $protein = "asp" || $protein = "glu" || $protein = "his" ]]
  then 
    for thetx in ${arrthetax[@]}
     do
	      j=$(($j+1))
        if [ $j == 1 ]
        then 
         restartcoor=mini3.rst7
        else
         prev=$(($j-1)) 
         restartcoor=heat${prev}_${theta}_${thetx}.rst7 
        fi 
        pmemd.cuda -O -i heating.mdin -c mini3.rst7 -p ${protein}.parm7 -ref mini3.rst7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout heating_${theta}_${thetx}.lambda -phmdstrt phmdstrt_${theta}_${thetx}.in -o heating_${theta}_${thetx}.mdout -r heating_${theta}_${thetx}.rst7 -x heating_${theta}_${thetx}.nc 
        wait
    done
  fi
done
wait

#################
# Equilibration #
#################


for restn in `seq 1 ${#restraints[@]}` # loop over number of restarts
do
echo "Stage 1 equilibration of asp
         &cntrl
          imin = 0, nstlim = $ensteps, dt = $ets,
          irest = 1, ntx = 5,ig = -1,
          temp0 = $etemp,
          ntc = 2, ntf = 2, tol = 0.00001
          ntwx = $ewfrq, ntwe = 0, ntwr = $ewrst, ntpr = $ewfrq
          cut = $cutoff, fswitch = 10.0, iwrap = 0, taup = 0.1    ! for Amber FF, delete 'fswitch = 10.0,'
          ntt = 3, gamma_ln = 1.0, ntb = 2, ntp = 1,              ! ntp (1 = isotropic position scaling)
          iphmd = 3, solvph = $crysph, 
          nscm = 0,
          ntr = 1, restraintmask = ':1-${nres}&!@H=', restraint_wt = ${restraints[$(($restn-1))]},
          ioutfm = 1, ntxo = 2,
        /" > equil${restn}.mdin

  for theta in ${arrtheta[@]}
  do
    if [[ $protein = "lys" || $protein = "arg" || $protein = "cys" ]]
    then
      if [ $restn == 1 ] 
        then 
            equilrestart="heating_${theta}.rst7"
        else 
            prev=$(($restn-1))
            equilrestart="equil${prev}_${theta}.rst7"
      fi
      pmemd.cuda -O -i equil${restn}.mdin -c $equilrestart -p ${protein}.parm7 -ref mini3.rst7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout equil${restn}.lambda -phmdstrt phmdstrt_${theta}.in -o equil${restn}_${theta}.mdout -r equil${restn}_${theta}.rst7 
    elif [[ $protein = "asp" || $protein = "glu" || $protein = "his" ]]
    then 

      for thetx in ${arrthetax[@]}
      do
        if [ $restn == 1 ] 
          then 
          equilrestart="heating_${theta}_${thetx}.rst7"
        else 
          prev=$(($restn-1))
          equilrestart="equil${prev}_${theta}_${thetx}.rst7"
        fi
        pmemd.cuda -O -i equil${restn}.mdin -c $equilrestart -p ${protein}.parm7 -ref mini3.rst7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout equil${restn}_${theta}_${thetx}.lambda -phmdstrt phmdstrt_${theta}_${thetx}.in -o equil${restn}_${theta}_${thetx}.mdout -r equil${restn}_${theta}_${thetx}.rst7 -x equil${restn}_${theta}_${thetx}.nc 
     done
   fi
  done 
done
wait

##############
# Production #
##############

echo "Production of $protein
 &cntrl
  imin=0, nstlim=$pnsteps, dt=$pts, 
  irest=1, ntx=5, ig=-1, 
  tempi=$etemp, temp0=$etemp, 
  ntc=2, ntf=2, tol = 0.00001,
  ntwx=$pwfrq, ntwe=$pwfrq, ntwr=$pwrst, ntpr=$pwfrq, 
  cut=$cutoff, fswitch = 10.0, iwrap=0,     ! for Amber FF, delete 'fswitch = 10.0,'
  ntt=3, gamma_ln=1.0, ntb=2, ntp=1,
  iphmd=3, solvph=$crysph,
/" > prod.mdin


for theta in ${arrtheta[@]}
do
 if [[ $protein = "lys" || $protein = "arg" || $protein = "cys" ]]
   then 
   pmemd.cuda -O -i prod.mdin -c equil${#restraints[@]}_${theta}.rst7 -p ${protein}.parm7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout prod_${theta}.lambda -phmdstrt phmdstrt_${theta}.in -o prod_${theta}.mdout -r prod_${theta}.rst7 
 elif [[ $protein = "asp" || $protein = "glu" || $protein = "his" ]]
  then 
  for thetx in ${arrthetax[@]}
   do
   pmemd.cuda -O -i prod.mdin -c equil${#restraints[@]}_${theta}_${thetx}.rst7 -p ${protein}.parm7 -phmdparm $phmdparm -phmdin prod.phmdin -phmdout prod_${theta}_${thetx}.lambda -phmdstrt phmdstrt_${theta}_${thetx}.in -o prod_${theta}_${thetx}.mdout -r prod_${theta}_${thetx}.rst7 -x prod_${theta}_${thetx}.nc 
   done
 fi
done
wait


exit 


# need to construct mini_?.min files
pmemd.cuda -O -i heating.mdin -p 3ruz_charmm.prmtop -c 3ruz_min1.rst7 -r 3ruz_heating.rst7 -ref 3ruz_min1.rst7 -phmdparm charmm_pme.parm -phmdin phmdin_start -o heating.mdout -x 3ruz_heating.nc

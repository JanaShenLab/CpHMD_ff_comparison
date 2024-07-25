# need to construct mini_?.min files
pmemd.cuda -O -i heating.mdin -p 2lzt_ff14.prmtop -c 2lzt_min1.rst7 -r 2lzt_heating.rst7 -ref 2lzt_min1.rst7 -phmdparm ff14sb_pme.parm -phmdin prod.phmdin -o heating.mdout -x 2lzt_heating.nc

# need to construct mini_?.min files
pmemd.cuda -O -i heating.mdin -p 3ruz_cphmd.prmtop -c 3ruz_min1.rst7 -r 3ruz_heating.rst7 -ref 3ruz_min1.rst7 -phmdparm ff19sb_pme.parm -phmdin prod.phmdin -o heating.mdout -x 3ruz_heating.nc

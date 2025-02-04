# need to construct mini_?.min files
pmemd.cuda -O -i heating.mdin -p 1i0e_cphmd.prmtop -c 1i0e_min1.rst7 -r 1i0e_heating.rst7 -ref 1i0e_min1.rst7 -phmdparm ff19sb_pme_cysfix.parm -phmdin phmdin_start -o heating.mdout -x 1i0e_heating.nc

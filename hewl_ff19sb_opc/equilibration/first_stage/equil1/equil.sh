# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.1.mdin -p 2lzt_cphmd.prmtop -c 2lzt_heating.rst7 -r 2lzt_equil_1.1.rst7 -ref 2lzt_heating.rst7 -phmdparm ff19sb_pme.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.1.mdout -x 2lzt_equil1.nc

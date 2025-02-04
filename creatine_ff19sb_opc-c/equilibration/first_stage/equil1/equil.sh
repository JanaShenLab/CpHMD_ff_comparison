# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.1.mdin -p 1i0e_cphmd.prmtop -c 1i0e_heating.rst7 -r 1i0e_equil_1.1.rst7 -ref 1i0e_heating.rst7 -phmdparm ff19sb_pme_cysfix.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.1.mdout -x 1i0e_equil1.nc

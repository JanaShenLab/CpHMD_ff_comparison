# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.2.mdin -p 3ruz_cphmd.prmtop -c 3ruz_equil_1.1.rst7 -r 3ruz_equil_1.2.rst7 -ref 3ruz_equil_1.1.rst7 -phmdparm ff19sb_pme.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.2.mdout -x 3ruz_equil1.nc

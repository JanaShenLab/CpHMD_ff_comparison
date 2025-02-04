# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.1.mdin -p 3ruz_charmm.prmtop -c 3ruz_heating.rst7 -r 3ruz_equil_1.1.rst7 -ref 3ruz_heating.rst7 -phmdparm charmm_pme.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.1.mdout -x 3ruz_equil1.nc

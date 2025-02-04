# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.2.mdin -p 6wgn_charmm.prmtop -c 6wgn_equil_1.1.rst7 -r 6wgn_equil_1.2.rst7 -ref 6wgn_equil_1.1.rst7 -phmdparm charmm_pme.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.2.mdout -x 6wgn_equil1.nc

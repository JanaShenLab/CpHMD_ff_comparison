# need to construct mini_?.min files
pmemd.cuda -O -i equil_1.1.mdin -p 6wgn_cphmd.prmtop -c 6wgn_heating.rst7 -r 6wgn_equil_1.1.rst7 -ref 6wgn_heating.rst7 -phmdparm ff19sb_pme_AarionC_CraigK.parm -phmdin prod.phmdin -phmdstrt phmdrestrt -o equil_1.1.mdout -x 6wgn_equil1.nc

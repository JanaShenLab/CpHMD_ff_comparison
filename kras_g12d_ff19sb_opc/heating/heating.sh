# need to construct mini_?.min files
pmemd.cuda -O -i heating.mdin -p 6wgn_cphmd.prmtop -c 6wgn_min1.rst7 -r 6wgn_heating.rst7 -ref 6wgn_min1.rst7 -phmdparm ff19sb_pme_AarionC_CraigK.parm -phmdin phmdin_start -o heating.mdout -x 6wgn_heating.nc

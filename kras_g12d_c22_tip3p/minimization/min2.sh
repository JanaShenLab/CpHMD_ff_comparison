# need to construct mini_?.min files
pmemd.cuda -O -i minimization1.mdin -p 6wgn_charmm.prmtop -c 6wgn_min1.rst7 -r 6wgn_min2.rst7 -o 6wgn_min_2.out -ref  6wgn_min1.rst7 -x 6wgn_min2.nc

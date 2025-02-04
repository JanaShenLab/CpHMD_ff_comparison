# need to construct mini_?.min files
pmemd.cuda -O -i minimization1.mdin -p 3ruz_cphmd.prmtop -c 3ruz_cphmd.rst7 -r 3ruz_min1.rst7 -o 3ruz_min_1.out -ref  3ruz_cphmd.rst7 -x 3ruz_min1.nc

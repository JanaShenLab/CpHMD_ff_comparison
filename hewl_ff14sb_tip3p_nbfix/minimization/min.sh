# need to construct mini_?.min files
pmemd.cuda -O -i minimization1.mdin -p 2lzt_cphmd.prmtop -c 2lzt.rst7 -r 2lzt_min1.rst7 -o 2lzt_min_1.out -ref  2lzt.rst7 -x 2lzt_min1.nc

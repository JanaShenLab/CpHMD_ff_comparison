# need to construct mini_?.min files
pmemd.cuda -O -i minimization2.mdin -p 1i0e_cphmd.prmtop -c 1i0e_min1.rst7 -r 1i0e_min2.rst7 -o 1i0e_min_2.out -ref  1i0e_cphmd.rst7 -x 1i0e_min2.nc

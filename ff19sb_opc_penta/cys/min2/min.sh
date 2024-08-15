# need to construct mini_?.min files
pmemd.cuda -O -i min_2.mdin -p cys.parm7 -c cys_min1.rst7 -r cys_min2.rst7 -o min_2.out -ref  cys_min1.rst7 -x cys_min2.nc

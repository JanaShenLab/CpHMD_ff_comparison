# need to construct mini_?.min files
pmemd.cuda -O -i min_1.mdin -p cys.parm7 -c cys.rst7 -r cys_min1.rst7 -o min_1.out -ref  cys.rst7 -x cys_min1.nc

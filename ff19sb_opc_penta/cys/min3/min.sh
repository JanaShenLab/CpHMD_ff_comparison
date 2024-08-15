# need to construct mini_?.min files
pmemd.cuda -O -i min_3.mdin -p cys.parm7 -c cys_min2.rst7 -r cys_min3.rst7 -o min_3.out -ref  cys_min2.rst7 -x cys_min3.nc

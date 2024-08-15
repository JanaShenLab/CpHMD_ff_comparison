# need to construct mini_?.min files
pmemd.cuda -O -i min_3.mdin -p asp.parm7 -c asp_min2.rst7 -r asp_min3.rst7 -o min_3.out -ref  asp_min2.rst7 -x asp_min3.nc

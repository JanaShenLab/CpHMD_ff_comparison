# need to construct mini_?.min files
pmemd.cuda -O -i min_2.mdin -p asp.parm7 -c asp_min1.rst7 -r asp_min2.rst7 -o min_2.out -ref  asp_min1.rst7 -x asp_min2.nc

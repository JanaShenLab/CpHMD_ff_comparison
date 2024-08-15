# need to construct mini_?.min files
pmemd.cuda -O -i min_1.mdin -p asp.parm7 -c asp.rst7 -r asp_min1.rst7 -o min_1.out -ref  asp.rst7 -x asp_min1.nc

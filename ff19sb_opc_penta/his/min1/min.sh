# need to construct mini_?.min files
pmemd.cuda -O -i min_1.mdin -p his.parm7 -c his.rst7 -r his_min1.rst7 -o min_1.out -ref  his.rst7 -x his_min1.nc

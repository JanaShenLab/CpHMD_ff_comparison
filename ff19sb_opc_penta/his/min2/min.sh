# need to construct mini_?.min files
pmemd.cuda -O -i min_2.mdin -p his.parm7 -c his_min1.rst7 -r his_min2.rst7 -o min_2.out -ref  his_min1.rst7 -x his_min2.nc

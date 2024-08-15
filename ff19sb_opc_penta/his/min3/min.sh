# need to construct mini_?.min files
pmemd.cuda -O -i min_3.mdin -p his.parm7 -c his_min2.rst7 -r his_min3.rst7 -o min_3.out -ref  his_min2.rst7 -x his_min3.nc

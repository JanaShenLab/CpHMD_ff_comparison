# need to construct mini_?.min files
pmemd.cuda -O -i min_1.mdin -p lys.parm7 -c lys.rst7 -r lys_min1.rst7 -o min_1.out -ref  lys.rst7 -x lys_min1.nc

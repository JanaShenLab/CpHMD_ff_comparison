# need to construct mini_?.min files
pmemd.cuda -O -i min_2.mdin -p lys.parm7 -c lys_min1.rst7 -r lys_min2.rst7 -o min_2.out -ref  lys_min1.rst7 -x lys_min2.nc

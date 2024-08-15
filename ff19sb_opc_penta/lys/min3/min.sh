# need to construct mini_?.min files
pmemd.cuda -O -i min_3.mdin -p lys.parm7 -c lys_min2.rst7 -r lys_min3.rst7 -o min_3.out -ref  lys_min2.rst7 -x lys_min3.nc

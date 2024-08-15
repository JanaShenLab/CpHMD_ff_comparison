# need to construct mini_?.min files
pmemd.cuda -O -i min_2.mdin -p glu.parm7 -c glu_min1.rst7 -r glu_min2.rst7 -o min_2.out -ref  glu_min1.rst7 -x glu_min2.nc

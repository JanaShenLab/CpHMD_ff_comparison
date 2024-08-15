# need to construct mini_?.min files
pmemd.cuda -O -i min_1.mdin -p glu.parm7 -c glu.rst7 -r glu_min1.rst7 -o min_1.out -ref  glu.rst7 -x glu_min1.nc

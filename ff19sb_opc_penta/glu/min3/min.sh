# need to construct mini_?.min files
pmemd.cuda -O -i min_3.mdin -p glu.parm7 -c glu_min2.rst7 -r glu_min3.rst7 -o min_3.out -ref  glu_min2.rst7 -x glu_min3.nc

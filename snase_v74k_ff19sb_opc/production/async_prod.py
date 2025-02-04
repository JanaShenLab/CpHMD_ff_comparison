import sys
#sys.path.append("./async_ph_replica_exchange")
sys.path.append("/home/rliu/softwares/async_ph_replica_exchange")
sys.path.append("/home/rliu/miniconda3/envs/cphmd-prep/lib/python3.6/site-packages")
import replica_exchange as re
import time
import os

# For equilibration at individual pHs
#first_equil_stage = int(sys.argv[1])
#second_equil_stage = int(sys.argv[2])
#phs = sys.argv[3:]
first_equil_stage = 2
second_equil_stage = 4
phs = '6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0 10.5'
phs = [i for i in phs.split()]
#for step in range(0, second_equil_stage):
#for step in range(3, second_equil_stage):
#    if step == 0:
#        re.do_replica_exchange(phs, 1, 'template_equil_2.{}.mdin'.format(step+1), '3ruz_cphmd.prmtop', 'ff19sb_pme.parm', 'prod.phmdin', 'equil_2.{}'.format(step+1), initial_restart_file = 'equil_1.{}.rst7'.format(first_equil_stage))
#    else:
#        re.do_replica_exchange(phs, 1, 'template_equil_2.{}.mdin'.format(step+1), '3ruz_cphmd.prmtop', 'ff19sb_pme.parm', 'prod.phmdin', 'equil_2.{}'.format(step+1), restart_directory = 'equil_2.{}'.format(step), restart = True)
#    print("Equilibration stage step {} finished.".format(step+1))

# For production
prod_stage = 26
curdir = os.getcwd()

for step in range(21, prod_stage):
    if step == 0:
        re.do_replica_exchange(phs, 1000, 'template_prod.mdin', '3ruz_cphmd.prmtop', 'ff19sb_pme.parm', 'prod.phmdin', 'output_stage{}'.format(step+1), restart_directory = 'equil_2.{}'.format(second_equil_stage), restart = True)
    else:
        re.do_replica_exchange(phs, 1000, 'template_prod.mdin', '3ruz_cphmd.prmtop', 'ff19sb_pme.parm', 'prod.phmdin', 'output_stage{}'.format(step+1), restart_directory = 'output_stage{}'.format(step), restart = True)
    print("Production stage step {} finished.".format(step+1))

# prepare pdb to only contain protein
pdb1='chaina_start.pdb'

# Change HIS to HSP for protonation
# -sel is which residues to reorder
# -out charmm22 is CHARMM-readable input
# -renumber starts residues/atoms at 1
# -segnames puts the segment names in (residues, GDP)
# -cleanaux reset AUX columns
# sed changes PRO0 to PROA for CHARMM
/home/craigp/software/mmtsb/perl/convpdb.pl -sel 1:5 -out charmm22 -renumber 1 -segnames -cleanaux $pdb1 | sed "s/PRO0/PROA/g" > chaina.pdb





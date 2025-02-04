#!/bin/bash 

###############################################################
# This script will help convert an CHARMM PDB to AMBER Format #
###############################################################

pdb="charmm_in.pdb"
out="6wgn_charmm_cphmd.pdb"
mmtsbdir="/home/craigp/software/mmtsb/perl/" # can download from git: https://github.com/mmtsb/toolset

######################
# Perform Conversion #
######################
# convert to amber
$mmtsbdir/convpdb.pl -out charmm $pdb > temp1.pdb

mv temp1.pdb $out 





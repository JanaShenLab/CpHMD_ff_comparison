#!/bin/bash 

###############################################################
# This script will help convert an CHARMM PDB to AMBER Format #
###############################################################

pdb="chaina_addh.pdb"
out="A_amber.pdb"
mmtsbdir="/home/craigp/software/mmtsb/perl/" # can download from git: https://github.com/mmtsb/toolset

######################
# Perform Conversion #
######################
# convert to amber
$mmtsbdir/convpdb.pl -out amber $pdb > temp1.pdb

# This section need was modified to handle Monomer A and Monomer B 

#First/last res of protein
firsres1=ALA
lastres1=ALA

# Conversion of residues
# 
# ACE = capped O
# NHE = capped N
# HIP titrateable histadine
# AS2 titrateable aspartic acid
# GL2 titrateable glutamate
sed "
s/CAY $firsres1/CH3 ACE/g;
s/ HY1 $firsres1/ H1  ACE/g;
s/ HY2 $firsres1/ H2  ACE/g;
s/ HY3 $firsres1/ H3  ACE/g;
s/ CY  $firsres1/ C   ACE/g;
s/ OY  $firsres1/ O   ACE/g;
s/ NT  $lastres1/ N   NHE/g;
s/ H1  $lastres1/ HN1 NHE/g;
s/ H2  $lastres1/ HN2 NHE/g;
s/HSP/HIP/g;
s/HB2 HIP/HB3 HIP/g;
s/HB1 HIP/HB2 HIP/g;
s/ASP/AS2/g;
s/GLU/GL2/g;
s/HSE/HIE/g;
s/HSD/HID/g;
" temp1.pdb > temp2.pdb

#s/ASP/AS2/g; add lines to sed formatting if you want to titrate ASP/GLU
#s/GLU/GL2/g;
mv temp2.pdb $out 

rm temp1.pdb 




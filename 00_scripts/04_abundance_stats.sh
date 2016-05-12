#!/bin/bash

#pre-requis
module load apps/git/1.8.5.3 
module load apps/trinityrnaseq/2.1.1



# Move to job submission directory
cd $PBS_O_WORKDIR


#Check stats
00_scripts/trinity_utils/util/TrinityStats.pl 05_trinity_assembly/Trinity.fasta > 05_trinity_assembly/results_stats.txt


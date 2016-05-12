#!/bin/bash

# Move to job submission directory
cd $(pwd)

#global variables
INPUTFILE="05_trinity_assembly/Trinity.fasta"
OUTPUTFILE="06_assembly_stats/results_stats.txt"

#Check stats
00_scripts/trinity_utils/util/TrinityStats.pl "$INPUTFILE" > "$OUTPUTFILE"


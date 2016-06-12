#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="stats"
#SBATCH -o log-stat.out
#SBATCH -c 1
#SBATCH -p ibis2
#SBATCH -A ibis2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=00-10:00
#SBATCH --mem=2000

cd $SLURM_SUBMIT_DIR


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#global variables
INPUTFILE="05_trinity_assembly/Trinity.fasta"
OUTPUTFILE="06_assembly_stats/results_stats.txt"

#Check stats
00_scripts/trinity_utils/util/TrinityStats.pl "$INPUTFILE" > "$OUTPUTFILE" 2>&1 | tee 98_log_files/"$TIMESTAMP"_assemblystats.log


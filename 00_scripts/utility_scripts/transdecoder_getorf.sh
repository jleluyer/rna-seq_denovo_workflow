#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="transdecoder"
#SBATCH -o log-transdecoder.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=5-00:00
#SBATCH --mem=50000

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#Global variables
INPUT="05_trinity_assembly/Trinity_cleaned.fasta"

./00_scripts/transdecoder_utils/TransDecoder.LongOrfs -t $INPUT 2>&1 | tee 98_log_files/"$TIMESTAMP"_transdecoder_getorf.log   

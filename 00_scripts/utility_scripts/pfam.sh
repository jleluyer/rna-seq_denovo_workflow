#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="pfam"
#SBATCH -o log-pfam.out
#SBATCH -c 4
#SBATCH -p ibis2
#SBATCH -A ibis2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=5-00:00
#SBATCH --mem=20000



cd $SLURM_SUBMIT_DIR


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#Global variables
INPUT="Trinity_cleaned.fasta.transdecoder_dir/longest_orfs.pep"
PFAMDB="/home/jelel8/Databases/pfam/Pfam-A.hmm"
OUTPUT="07_de_results/TrinotatePFAM.out"


#prepare DB

hmmpress $PFAMDB

#run hmmer suite

hmmscan --cpu 4 --domtblout $OUTPUT $PFAMDB $INPUT > pfam.log 

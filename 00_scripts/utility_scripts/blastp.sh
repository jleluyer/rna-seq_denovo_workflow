#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="blastp"
#SBATCH -o log-blastp.out
#SBATCH -c 5
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
INPUT="longest_orfs.pep"
DATAFOLDER="Trinity_cleaned.fasta.transdecoder_dir"
UNIPROT="/biodata/bio_sequences/proteins/uniprot/current/uniprot_sprot.fasta"
DATAFOLDEROUT="07_de_results"
OUTPUT="blastp.outfmt6"


cat "$DATAFOLDER"/"$INPUT" | parallel -j 5 -k --block 10k --recstart '>' --pipe blastp -db "$UNIPROT" -query - -outfmt 6 -max_target_seqs 1 -evalue 1e-6 > "$DATAFOLDEROUT"/"$OUTPUT"

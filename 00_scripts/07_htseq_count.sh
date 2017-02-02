#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="htseq"
#SBATCH -o log-htseq.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=02-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#Global variables
DATAINPUT="07_de_results"
DATAOUTPUT="07_de_results"
GFF_FOLDER="01_info_files"
GFF_FILE="transcriptome.gff3"


#sort bam files
for i in $(ls 07_de_results/*.bam|sed 's/.bam//g'|sort -u)
do
samtools sort "$i".bam "$i".sorted
samtools index "$i".sorted.bam
done

#create gff3 file
# import function
git clone https://github.com/scottcain/chado_test

chado_test/chado/bin/gmod_fasta2gff3.pl --fasta_dir  05_trinity_assembly/Trinity.filtered.fasta --gfffilename "$GFF_FOLDER"/"$GFF_FILE" --nosequence --type CDS 

# launch htseqcount
for i in $(ls 07_de_results/*sorted.bam)
do
base="$(basename $i)"

htseq-count -f bam -s no -t CDS -r pos -i Name "$DATAINPUT"/"$base" "$GFF_FOLDER"/"$GFF_FILE" >> "$DATAOUTPUT"/htseq-count_"$base".txt

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_htseq.log

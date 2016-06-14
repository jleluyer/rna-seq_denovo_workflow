#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="merge"
#SBATCH -o log-merge.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=2-00:00
#SBATCH --mem=10000

<<<<<<< HEAD
cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

INPUTFOLDER="03_trimmed"
OUTPUTFOLDER="04_merged"

	cat "$INPUTFOLDER"/*_R1.paired.fastq.gz >> "$OUTPUTFOLDER"/all_reads.left.fastq
 
	cat "$INPUTFOLDER"/*_R2.paired.fastq.gz >> "$OUTPUTFOLDER"/all_reads.right.fastq

=======
#move to present directory
cd $(pwd)

#cat all reads
	cat "$INPUTFOLDER"/*_R1.paired.fastq.gz > "$OUTPUTFOLDER"/all_reads.left.fastq.gz
 
	cat "$INPUTFOLDER"/*_R2.paired.fastq.gz > "$OUTPUTFOLDER"/all_reads.right.fastq.gz
>>>>>>> 8629e02ffad09c4df82ffb278128308c999cbded

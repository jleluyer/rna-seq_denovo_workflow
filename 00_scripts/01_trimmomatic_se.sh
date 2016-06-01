#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="trim"
#SBATCH -o log-trim_pe.out
#SBATCH -c 8
#SBATCH -p ibismini
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=0-20:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#Global variables
ADAPTERFILE="01_info_files/univec.fasta"
TRIMMOMATIC_JAR="/prg/trimmomatic/0.36/trimmomatic-0.36.jar"

for file in $(ls 02_data/*.f*q.gz|perl -pe 's/_R[12].f(ast)?q.gz//')
do
        base=$(basename "$file")

java -Xmx40G -jar $TRIMMOMATIC_JAR SE \
        -phred33 \
        -threads 8 \
        02_data/"$base"_R1.fastq.gz \
        03_trimmed/"$base"_R1.trimmed.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:20:7 \
        LEADING:20 \
        TRAILING:20 \
        SLIDINGWINDOW:30:30 \
        MINLEN:60 

done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmomatic_se.log 

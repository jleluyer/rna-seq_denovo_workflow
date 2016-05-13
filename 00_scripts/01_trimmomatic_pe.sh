#!/bin/bash
#$ -N trimmomatic
#$ -M userID
#$ -m beas
#$ -pe smp 8
#$ -l h_vmem=20G
#$ -l h_rt=20:00:00
#$ -cwd
#$ -S /bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


#gloe variables
ADAPTERFILE="/rap/userID/00_ressources/02_databases/univec/univec.fasta"
TRIMMOMATIC_JAR="/prg/trimmomatic/0.36/trimmomatic-0.36.jar"
# Move to job submission directory
cd $SGE_O_WORKDIR

for file in $(ls 02_data/*.f*q.gz|perl -pe 's/_R[12].f(ast)?q.gz//')
do
	base=$(basename "$file")

java -Xmx40G -jar $TRIMMOMATIC_JAR PE \
        -phred33 \
	-threads 8 \
        02_data/"$base"_R1.fastq.gz \
        02_data/"$base"_R2.fastq.gz \
        03_trimmed/"$base"_R1.paired.fastq.gz \
        03_trimmed/"$base"_R1.single.fastq.gz \
        03_trimmed/"$base"_R2.paired.fastq.gz \
        03_trimmed/"$base"_R2.single.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:20:7 \
        LEADING:20 \
        TRAILING:20 \
        SLIDINGWINDOW:30:30 \
        MINLEN:60
 
done 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmomatic_pe.log       

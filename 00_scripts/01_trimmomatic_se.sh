#!/bin/bash
#$ -N trimmomatic_se
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


#Global variables
ADAPTERFILE="/path/to/file.fasta"
TRIMMOMATIC_JAR="/prg/trimmomatic/0.36/trimmomatic-0.36.jar"

# Move to job submission directory
cd $PBS_O_WORKDIR


base=__BASE__

java -Xmx40G -jar $TRIMMOMATIC_JAR SE \
        -phred33 \
        02_data/"$base".fastq.gz \
        03_trimmed/"$base"trimmed.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:20:7 \
        LEADING:20 \
        TRAILING:20 \
        SLIDINGWINDOW:30:30 \
        MINLEN:60 2>&1 | tee 98_log_files/"$TIMESTAMP"_trimmomatic_"$base".log

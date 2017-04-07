#!/bin/bash
#PBS -N trimmomatic__BASE__
#PBS -o trimmomatic__BASE__.out
#PBS -l walltime=02:00:00
#PBS -l mem=60g
#####PBS -m ea 
#PBS -l ncpus=8
#PBS -q omp
#PBS -r n

cd $PBS_O_WORKDIR


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


# Global variables

ADAPTERFILE="/home1/datawork/jleluyer/00_ressources/univec/univec.fasta"
NCPU=8
base=__BASE__
TRIMMOMATIC_JAR="/datawork/fsi1/bioinfo/home12-copycaparmor/softs/sources/trimmomatic/Trimmomatic-0.36/trimmomatic-0.36.jar"

java -Xmx40G -jar $TRIMMOMATIC_JAR PE \
	-threads 8 \
	-phred33 \
        02_data/"$base"_1.fastq.gz \
        02_data/"$base"_2.fastq.gz \
        03_trimmed/"$base"_R1.paired.fastq.gz \
        03_trimmed/"$base"_R1.single.fastq.gz \
        03_trimmed/"$base"_R2.paired.fastq.gz \
        03_trimmed/"$base"_R2.single.fastq.gz \
        ILLUMINACLIP:"$ADAPTERFILE":2:20:7 \
        LEADING:20 \
        TRAILING:20 \
        SLIDINGWINDOW:30:30 \
        MINLEN:40 2> 98_log_files/log.trimmomatic.pe."$TIMESTAMP"      

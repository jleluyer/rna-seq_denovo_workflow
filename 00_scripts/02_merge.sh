#!/bin/bash
#PBS -A userID
#PBS -N trimmomatic__BASE__
#PBS -o trimmomatic__BASE__.out
#PBS -e trimmomatic__BASE__.err
#PBS -l walltime=02:00:00
#PBS -M userEmail
#PBS -m ea
#PBS -l nodes=1:ppn=8
#PBS -r n


TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#pre-requis

module load compilers/gcc/4.8
module load apps/mugqic_pipeline/2.1.1
module load mugqic/java/jdk1.7.0_60
module load mugqic/trimmomatic/0.35

INPUTFOLDER="03_trimmed"
OUTPUTFOLDER="04_merged"


cd $(pwd)

for file in $(ls 02_data/*.f*q.gz|perl -pe 's/_R[12].f(ast)?q.gz//')
do
	base=$(basename "$file")


	cat "$INPUTFOLDER"/"$base"_R1.paired.fastq.gz > all_reads.left.fastq.gz
 
	cat "$INPUTFOLDER"/"$base"_R2.paired.fastq.gz > all_reads.left.fastq.gz


done  2>&1 | tee 98_log_files/"$TIMESTAMP"_mere.log        

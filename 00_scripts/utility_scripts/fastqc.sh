#!/bin/bash
#$ -N fastqc
#$ -M userID
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=10:00:00
#$ -cwd
#$ -S /bin/bash

#Move to job submission directory
cd $SGE_O_WORKDIR

mkdir fastqc_dir
for file in $(ls 02_data/.*f*q.gz|sed 's/.f(ast)?q.gz//g')
do 
base=$(basename $file)
        mkdir  ./fastqc.dir/"$base".dir
        fastqc -o ./fastqc.dir/"$base".dir -f fastq "$base".fastq.gz
done

#!/bin/bash

INPUTFOLDER="03_trimmed"
OUTPUTFOLDER="04_merged"

#move to present directory

cd $(pwd)

for file in $(ls 02_data/*.f*q.gz|perl -pe 's/_R[12].f(ast)?q.gz//')
do
	base=$(basename "$file")

	cat "$INPUTFOLDER"/"$base"_R1.paired.fastq.gz > all_reads.left.fastq.gz
 
	cat "$INPUTFOLDER"/"$base"_R2.paired.fastq.gz > all_reads.left.fastq.gz


done  2>&1 | tee 98_log_files/"$TIMESTAMP"_mere.log        

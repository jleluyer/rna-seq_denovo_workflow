#!/bin/bash

INPUTFOLDER="03_trimmed"
OUTPUTFOLDER="04_merged"

#move to present directory
cd $(pwd)

#cat all reads
	cat "$INPUTFOLDER"/*_R1.paired.fastq.gz > "$OUTPUTFOLDER"/all_reads.left.fastq.gz
 
	cat "$INPUTFOLDER"/*_R2.paired.fastq.gz > "$OUTPUTFOLDER"/all_reads.right.fastq.gz

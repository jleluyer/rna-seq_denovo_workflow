#!/bin/bash
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
TRANSCRIPTOME="05_trinity_assembly/Trinity.fasta"
INFOFILE="01_info_files/samples_file"

# Move to job submission directory
cd $PBS_O_WORKDIR

#  Required:
trans=" --trinity_fasta $TRANSCRIPTOME"        	#Trinity fasta file
info_samples="--samples_file $INFOFILE"        		#tab-delimited text file indicating biological replicate relationships.
                                   			#ex.
#  Optional:
interactive="-I"                             # Interactive mode, waits between commands.

trinity_utils/util/run_RSEM_from_samples_file.pl $transcriptome $infosamples $interactive 2>&1 | tee 98_log_files/"$TIMESTAMP"_rsem.log


#!/bin/bash
#$ -N trandecod_predict
#$ -M userID
#$ -m beas
#$ -pe smp 1
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
INPUT="05_trinity_assembly/Trinity.fasta"

./00_scripts/transdecoder_utils/TransDecoder.Predict -t $INPUT 2>&1 | tee 98_log_files/"$TIMESTAMP"_transdecoder_predict.log 

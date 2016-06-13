#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="corset"
#SBATCH -o log-corset.out
#SBATCH -c 8
#SBATCH -p ibis2
#SBATCH -A ibis2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=01-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

for FILE in $(ls 07_de_results/*.bam)
do
  corset -r true-stop $FILE &
done
wait
corset -g 1,1,1,2,2,2 -n A1,A2,A3,B1,B2,B3 -i corset 07_de_results/*.corset-reads done 2>&1 | tee 98_log_files/"$TIMESTAMP"_corset.log

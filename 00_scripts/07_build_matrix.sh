#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="trans_matrix"
#SBATCH -o log-matrix.out
#SBATCH -c 1
#SBATCH -p ibismax
#SBATCH -A ibismax
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=02-00:00
#SBATCH --mem=50000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"


ls 07_de_results/*.genes.results >01_info_files/list.results.txt

#Required:
meth="--est_method RSEM"            #RSEM|eXpress|kallisto  (needs to know what format to expect)

# Options:
norm="--cross_sample_norm none"          #TMM|UpperQuartile|none   (default: TMM)
#name_dir="--name_sample_by_basedir"     #name sample column by dirname instead of filename
#	base_dir="--basedir_index -2"           #default(-2)

out_pref="--out_prefix matrix.nonorm"          #default: 'matrix'
listfile="--samples_file 01_info_files/list.results.txt" 	#rsem results
#run estimate to matrix
00_scripts/trinity_utils/util/abundance_estimates_to_matrix.pl $meth $norm \
07_de_results/rsem_DH-1MA.genes.results \
07_de_results/rsem_DH-4MA.genes.results \
07_de_results/rsem_DH-5MA.genes.results \
07_de_results/rsem_DL-4MA.genes.results \
07_de_results/rsem_DL-5MA.genes.results \
07_de_results/rsem_DL-6MA.genes.results \
07_de_results/rsem_WH-1MA.genes.results \
07_de_results/rsem_WH-2MA.genes.results \
07_de_results/rsem_WH-3MA.genes.results \
07_de_results/rsem_WL-1MA.genes.results \
07_de_results/rsem_WL-3MA.genes.results \
07_de_results/rsem_WL-6MA.genes.results \
$name_dir $base_dir $out_pref 2>&1 | tee 98_log_files/"$TIMESTAMP"_matrix.log

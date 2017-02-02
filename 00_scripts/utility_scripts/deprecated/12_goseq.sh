#!/bin/bash
#$ -N goseq
#$ -M userID
#$ -m beas
#$ -pe smp 1
#$ -l h_vmem=60G
#$ -l h_rt=20:00:00
#$ -cwd
#$ -S /bin/bash

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#Move to job submission directory
cd $SGE_O_WORKDIR

#Global variable
GO_ASSIGN="07_de_resuls/go_annotations.txt"
FACTOR_LAB="01_info_files/factor_labeling.txt"
LIST_GEN="path/to/list1of/gene/to/test"
GEN_LENGTH="path/to/file/length/gene"

/Analysis/DifferentialExpression/run_GOseq.pl \
                       --factor_labeling  factor_labeling.txt \
                       --GO_assignments go_annotations.txt \
                       --lengths gene.lengths.txt
#Trinity global
# Required:
###############################################################################################
#
fact_label="--factor_labeling $FACTOR_LAB"       #tab delimited file with format:  factor<tab>feature_id
#   or
gen_single_fact="--genes_single_factor $LIST_GEN"   #list of genes to test (can be a matrix, only the first column is used for gene IDs)

go_assign="--GO_assignments $GO_ASSIGN"        #extracted GO assignments with format: feature_id <tab> GO:000001,GO:00002,...

len="--lengths $GEN_LENGTH"               feature lengths with format:  feature_id <tab> length

###############################################################################################



# run clustering
00_scripts/trinity_utils/Analysis/DifferentialExpression/run_GOseq.pl \
			$fact_label $gen_single_fact $go_assign $len 2>&1 | tee 98_log_files/"$TIMESTAMP"_goseq.log

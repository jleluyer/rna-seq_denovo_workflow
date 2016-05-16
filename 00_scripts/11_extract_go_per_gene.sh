#!/bin/bash
#$ -N go_assign
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
TRINOTATE_FILE="01_info_files/trinotate.xls"

#Trinity global
# Required:

trinotate_file="--Trinotate_xls $TRINOTATE_FILE"     # Trinotate.xls file.

gene_mode="--gene"
 or 
trans_mode="--trans"         #gene or transcript-mode

# Optional:
ances_terms="--include_ancestral_terms"    # climbs the GO DAG, and incorporates
	                               #  all parent terms for an assignment.


# run clustering
00_scripts/trinotate_utils/util/extract_GO_assignments_from_Trinotate_xls.pl \
					$gene_mode $trans_mode $ances_terms > 07_de_resuls/go_annotations.txt 

 #!/bin/bash
#$ -N matrix
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

# Move to job submission directory
cd $SGE_O_WORKDIR

#Required:
meth="--est_method <string>"            #RSEM|eXpress|kallisto  (needs to know what format to expect)

# Options:
norm="--cross_sample_norm TMM"          #TMM|UpperQuartile|none   (default: TMM)
name_dir="--name_sample_by_basedir"     #name sample column by dirname instead of filename
base_dir="--basedir_index -2"           #default(-2)

out_pref="--out_prefix matrix"          #default: 'matrix'

#run estimate to matrix
00_scripts/trinity_utils/util/abundance_estimates_to_matrix.pl $meth $norm $name_dir \
         $base_dir $out_pref \
         sample1.results sample2.results ... 

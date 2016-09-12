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

ls 07_de_results/*.genes.results >01_info_files/list.results.txt

#Required:
meth="--est_method RSEM"            #RSEM|eXpress|kallisto  (needs to know what format to expect)

# Options:
norm="--cross_sample_norm TMM"          #TMM|UpperQuartile|none   (default: TMM)
#name_dir="--name_sample_by_basedir"     #name sample column by dirname instead of filename
#	base_dir="--basedir_index -2"           #default(-2)

out_pref="--out_prefix matrix"          #default: 'matrix'
listfile="--samples_file 01_info_files/list.results.txt" 	#rsem results
#run estimate to matrix
00_scripts/trinity_utils/util/abundance_estimates_to_matrix.pl $meth $norm \
         $name_dir $base_dir $out_pref $listfile \
         sample1.results sample2.results ... 2>&1 | tee 98_log_files/"$TIMESTAMP"_matrix.log

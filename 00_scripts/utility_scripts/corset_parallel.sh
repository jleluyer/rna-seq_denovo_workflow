#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="corset"
#SBATCH -o log-corset.out
#SBATCH -c 1
#SBATCH -p ibismini
#SBATCH -A ibismini
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


#global variables

#list_double="-d <double list>" 			#A comma separated list of distance thresholds. The range must be
	                  			#between 0 and 1. e.g -d 0.4,0.5. If more than one distance threshold
	                  			#is supplied, the output filenames will be of the form:
	                  			#counts-<threshold>.txt and clusters-<threshold>.txt 
	                  			#Default: 0.3

#log_lik_tresh="-D <double>"      		#The value used for thresholding the log likelihood ratio. The default 
	                  			#value will depend on the number of degrees of freedom (which is the 
	                  			#number of groups -1). By default D = 17.5 + 2.5 * ndf, which corresponds 
	                  			#approximately to a p-value threshold of 10^-5, when there are fewer than
	                  			#10 groups.

mincov="-m 10"         			#Filter out any transcripts with fewer than this many reads aligning.
	                  			#Default: 10
#grouping="-g DH1MA,DH1MA,DH4BA,DH4MA,DH4MA,DH5BA,DH5MA,DH6BA,DL1BA,DL1BA,DL2BA,DL2BA,DL3BA,DL3BA,DL4MA,DL4MA,DL5MA,DL5MA,DL6MA,DL6MA,Small1A,Small1A,Small2A,Small2A,Small3A,Small3A,WH1BA,WH1MA,WH2BA,WH2BA,WH2MA,WH2MA,WH3BA"
	                  			#groups. The parameter must be a comma separated list (no spaces), with the 
	                  			#groupings given in the same order as the bam filename. For example:
	                  			#-g Group1,Group1,Group2,Group2 etc. If this option is not used, each sample
	                  			#is treated as an independent experimental group.

#outpref="-p <string>"      			#Prefix for the output filenames. The output files will be of the form
	                  			#<prefix>-counts.txt and <prefix>-clusters.txt. Default filenames are:
	                  			#counts.txt and clusters.txt

#outputover="-f <true/false"  			#Specifies whether the output files should be overwritten if they already exist.
	                  			#Default: false

#names="-n DHM-r1,DHM-r2,DHB-r1,DHM-r3,DHM-r4,DHB-r2,DHM-r5,DHB-r3,DLB-r1,DLB-r2,DLB-r3,DLB-r4,DLB-r5,DLB-r6,DLM-r1,DLM-r2,DLM-r3,DLM-r4,DLM-r5,DLM-r6,Small1-r1,Small1-r2,Small2-r1,Small2-r2,Small3-r1,Small3-r2,WHB-r1,WHM-r1,WHB-r2,WHB-3,WHM-r2,WHM-r3,WHB-r4"
	                  			#This should be a comma separated list without spaces.
	                  			#e.g. -n Group1-ReplicateA,Group1-ReplicateB,Group2-ReplicateA etc.
	                  			#Default: the input filenames will be used.

#summary_fie="#-r <true/true-stop/false>"       	#Output a file summarising the read alignments. This may be used if you
	                  			#would like to read the bam files and run the clustering in seperate runs
	                  			#of corset. e.g. to read input bam files in parallel. The output will be the
	                  			#bam filename appended with .corset-reads.
	                  			#Default: false

input_type="-i bam"  			#The input file type. Use -i corset, if you previously ran
	                 			#corset with the -r option and would like to restart using those
	                  			#read summary files. Running with -i corset will switch off the -r option.
	                  			#Default: bam



00_scripts/corset_utils/corset $list_double $log_lik_tresh $mincov $grouping $outpref $outputover $names $input_type 07_de_results/*.bam 2>&1 | tee 98_log_files/"$TIMESTAMP"_corset.log

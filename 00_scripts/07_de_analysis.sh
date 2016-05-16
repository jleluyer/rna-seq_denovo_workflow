#!/bin/bash
#$ -N de_analysis
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
PAIR_COMP="01_info_files/pair_comparison.txt"
MATRIX="/path/to/matrix/files" 
SAMPLE_REPLICATE="01_info_files/sample_replicates.txt"

#Trinity variable
#Required:
 
matrix="--matrix $MATRIX"               #matrix of raw read counts (not normalized!)
 
method="--method DEseq2"            # edgeR|DESeq2|voom|ROTS
                                    # note: you should have biological replicates.
                                   #  edgeR will support having no bio replicates with
                                    # a fixed dispersion setting. 
# Optional:
sample_rep="--samples_file $SAMPLE_REPLICATE"     	 #tab-delimited text file indicating biological replicate relationships.
                		                   	 #ex.
 		                                      	 # cond_A    cond_A_rep1
                                		         # cond_A    cond_A_rep2
                                        		 # cond_B    cond_B_rep1
                             				 # cond_B    cond_B_rep2
#  General options:
min_row_count="--min_rowSum_counts 2"       #default: 2  (only those rows of matrix meeting requirement will be tested)
output="--output 07_de_results/"$method"_out_dir"                      #name of directory to place outputs (default: $method.$pid.dir)
ref_sample="--reference_sample <string>"    			# name of a sample to which all other samples should be compared.
                             					# (default is doing all pairwise-comparisons among samples)
contrasts="--contrasts $PAIR_COMP"            # file (tab-delimited) containing the pairs of sample comparisons to perform.
                              		   	# ex. 
                                      		# cond_A    cond_B
                                       		# cond_Y    cond_Z
## EdgeR-related parameters
## (no biological replicates)
disp="--dispersion <float>"            # edgeR dispersion value (Read edgeR manual to guide your value choice)
## ROTS parameters
rots_b="--ROTS_B 500"                   # number of bootstraps and permutation resampling (default: 500)
rots_k="--ROTS_K 5000"                   # largest top genes size (default: 5000)

#create variable for log file name
METH=$(echo $method|sed 's/--method //g')

# Run DE analysis
00_scripts/trinity_utils/Analysis/DifferentialExpression/run_DE_analysis.pl $matrix $PAIR_COMP $method \
						$sample_rep $min_row_count $output \
						$ref_sample $contrasts $disp $rots_b $rots_k 2>&1 | tee 98_log_files/"$TIMESTAMP"_de_"$METH".log 

 ###############################################################################################
 #
 #   Documentation and manuals for various DE methods.  Please read for more advanced and more
 #   fine-tuned DE analysis than provided by this helper script.
 #
 #  edgeR:       http://www.bioconductor.org/packages/release/bioc/html/edgeR.html
 #  DESeq2:      http://bioconductor.org/packages/release/bioc/html/DESeq2.html    
 #  voom/limma:  http://bioconductor.org/packages/release/bioc/html/limma.html
 #  ROTS:        http://www.btk.fi/research/research-groups/elo/software/rots/
 #
 ###############################################################################################

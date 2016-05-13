#!/bin/bash
#$ -N assess_read_representation
#$ -M userID
#$ -m beas
#$ -pe smp 8
#$ -l h_vmem=60G
#$ -l h_rt=20:00:00
#$ -cwd
#$ -S /bin/bash

#Move to job submission directory
cd $SGE_O_WORKDIR



#Global variables
TRANSCRIPTOME="05_trinity_assembly/Trinity.fasta"
READSLEFT="04_merged/*.left.fastq.gz"
READSRIGHT="04_merged/*.right.fastq.gz"
#READSSINGLE="03_trimmed/*.left.fastq.gz"

#########################################################################
#Required

#  If Paired-end:
left="--left $READSLEFT"
right="--right $READSRIGHT"

#  or Single-end:
#single="--single $READSSINGLE"

target="--target $TRANSCRIPTOME"            	#multi-fasta file containing the target sequences (should be named {refName}.fa )
seq="--seqType fq"           			#fa | fq    (fastA or fastQ format)
aligner="--aligner bowtie"           		#bowtie, bowtie2

# Optional:
#strand="--SS_lib_type <string>"       		# strand-specific library type:  single: F or R  paired: FR or RF
           	                       		# 3 examples:  single RNA-Ligation method:  F
                                             	# single dUTP method: R
                                             	# paired dUTP method: RF
output="--output 06_assembly_stats/assess_read_count_out"                  #output directory (default ${aligner}_out)

 
tophits="--num_top_hits 20"        #(default: 20) 

#intermediate="--retain_intermediate_files"    				 #retain all the intermediate sam files produced (they take up lots of space! and there's lots of them)
prep_rsem="--prep_rsem"                    	# prep the rsem-ready files
run_rsem="--run_rsem"                     	# execute rsem (implies --prep_rsem)
trinmode="--trinity_mode"       		#extract gene/trans mapping info from Trinity.fasta file directly
#trans_map="--gene_trans_map <string>"    	#rsem gene-to-transcript mapping file to use.
max_dist="--max_dist_between_pairs 2000"        #default (2000) 
#just_prep="--just_prep_build"               #just prepare the bowtie-build and stop.



#assess read count in assembly
00_scripts/trinity_utils/util/bowtie_PE_separate_then_join.pl $target $seq $single $left $right \
	$output $aligner $trinmode \
	$strand $tophits $intermediate $prep_rsem \
	$run_rsem $trans_map $max_dist $just_prep 2>&1 | tee 98_log_files/"$TIMESTAMP"_assess_read_count.log


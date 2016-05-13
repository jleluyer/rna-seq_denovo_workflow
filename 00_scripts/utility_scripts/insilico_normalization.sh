#!/bin/bash
#$ -N reads_normalization
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

seq="--seqType fq"           			#fa | fq    (fastA or fastQ format)

mem="--JM 90G" 					#:(Jellyfish Memory) number of GB of system memory to use for 
                            			#k-mer counting by jellyfish  (eg. 10G) *include the 'G' char
#strand="--SS_lib_type <string>"       		# strand-specific library type:  single: F or R  paired: FR or RF
           	                       		# 3 examples:  single RNA-Ligation method:  F
                                             	# single dUTP method: R
                                             	# paired dUTP method: RF

#Or, if you have read collections in different files you can use 'list' files, where each line in a list
 #  file is the full path to an input file.  This saves you the time of combining them just so you can pass
 #  a single file for each direction.
left_list="--left_list  <string>"		#left reads, one file path per line
right_list="--right_list <string>" 		#right reads, one file path per line


pairs="--pairs_together" 			#process paired reads by averaging stats between pairs and retaining linking info.

output="--output 10_normalized"			

cpu="--CPU 2"					#number of threads to use (default: = 2)
parallel_stat="--PARALLEL_STATS"		#:generate read stats in parallel for paired reads

kmer="--KMER_SIZE 25"               		#default 25

max_pct="--max_pct_stdev 200"           	#maximum pct of mean for stdev of kmer coverage across read (default: 200)

nocleanup="--no_cleanup"                    	#leave intermediate files                      
tmp_dir="--tmp_dir_name <string>"         	#default("tmp_normalized_reads")


#run normalization
00_scripts/trinity_utils/util/util/insilico_read_normalization.pl $seq $single $left $right \
	$output $mem $left_list $right_list \
	$pairs $cpu $parallel_stat $kmer $max_pct \
	$nocleanup $tmp_dir 2>&1 | tee 98_log_files/"$TIMESTAMP"_normalization.log 
	$run_rsem $trans_map $max_dist $just_prep 2>&1 | tee 98_log_files/"$TIMESTAMP"_assess_read_count.log


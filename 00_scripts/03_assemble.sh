#!/bin/bash

#SBATCH -D ./ 
#SBATCH --job-name="assemble"
#SBATCH -o log-assemble.out
#SBATCH -c 8
#SBATCH -p ibis2
#SBATCH -A ibis2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=type_your_mail@ulaval.ca
#SBATCH --time=10-00:00
#SBATCH --mem=220000

cd $SLURM_SUBMIT_DIR

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#Global variables
READSLEFT="04_merged/all_left.fq"
READSRIGHT="04_merged/all_right.fq"
#READSSINGLE="03_trimmed/*.trimmed.fastq.gz"

#Trinity variables
##Required
seqtype="--seqType fq"	     		# type of reads: ( fa, or fq )

mem="--max_memory 200G"   		# suggested max memory to use by Trinity where limiting can be enabled. (jellyfish, sorting, etc)
                            		# provied in Gb of RAM, ie.  '--max_memory 10G'
#paired reads:
left="--left  $READSLEFT"    		#left reads, one or more file names (separated by commas, no spaces)
right="--right $READSRIGHT"    		#right reads, one or more file names (separated by commas, no spaces)
#single-end:
#single="--single $READSSINGLE"   		#single reads, one or more file names, comma-delimited 
						#(note, if single file contains pairs, can use flag: --run_as_paired )
##Optionnal
#strand="--SS_lib_type <string> "        	#Strand-specific RNA-Seq read orientation.
                                  		# if paired: RF or FR,
                                   		#if single: F or R.   (dUTP method = RF)
                                   		#See web documentation.
cpu="--CPU 8" 	                    		#number of CPUs to use, default: 2
mincontiglength="--min_contig_length 200" 	#minimum assembled contig length to report
                                   		#(def=200)
#corlongread="--long_reads <string>"	        #fasta file containing error-corrected or circular consensus (CCS) pac bio reads
#genomeguided="--genome_guided_bam <string>"     #genome guided mode, provide path to coordinate-sorted bam file.
                                   		#(see genome-guided param section under --show_full_usage_info)
#jaccard="--jaccard_clip"                  	#:option, set if you have paired reads and
                                   		#you expect high gene density with UTR
                                   		#overlap (use FASTQ input file format
                                   		#for reads).
                                   		#(note: jaccard_clip is an expensive
                                   		#operation, so avoid using it unless
                                   		#necessary due to finding excessive fusion
                                   		#transcripts w/o it.)
#trim="--trimmomatic"      			#run Trimmomatic to quality trim reads
                                        	#see '--quality_trimming_params' under full usage info for tailored settings.
#normalize="--normalize_reads"               	#run in silico normalization of reads. Defaults to max. read coverage of 50.
                                       		#see '--normalize_max_read_cov' under full usage info for tailored settings.
#notphase2="--no_distributed_trinity_exec"   	#do not run Trinity phase 2 (assembly of partitioned reads), and stop after generating command list.
output="--output 05_trinity_assembly_200/"              	#name of directory for output (will be
                                   		#created if it doesn't already exist)
                                   		#default( your current working directory: "/home/leluyer/trinity_out_dir" 
                                    		#note: must include 'trinity' in the name as a safety precaution! )
#cleanup="--full_cleanup"                  	#only retain the Trinity fasta file, rename as ${output_dir}.Trinity.fasta


00_scripts/trinity_utils/Trinity $seqtype $mem $left $right $single \
	$strand $cpu $mincontiglength $corlongread \
	$genomeguided $jaccard $normalize $notphase2 \
	$output $cleanup 2>&1 | tee 98_log_files/"$TIMESTAMP"_trinityassembly.log



#  --cite                          :show the Trinity literature citation
#
#  --verbose                       :provide additional job status info during the run.
#
#  --version                       :reports Trinity version (v2.1.1) and exits.
#
#  --show_full_usage_info          :show the many many more options available for running Trinity (expert usage).
#
#
###############################################################################
#
#  *Note, a typical Trinity command might be:
#
#        Trinity --seqType fq --max_memory 50G --left reads_1.fq  --right reads_2.fq --CPU 6
#
#
#    and for Genome-guided Trinity:
#
#        Trinity --genome_guided_bam rnaseq_alignments.csorted.bam --max_memory 50G
#                --genome_guided_max_intron 10000 --CPU 6
#
#     see: /software6/apps/trinityrnaseq/2.1.1_gcc/sample_data/test_Trinity_Assembly/
#          for sample data and 'runMe.sh' for example Trinity execution
#
#     For more details, visit: http://trinityrnaseq.github.io


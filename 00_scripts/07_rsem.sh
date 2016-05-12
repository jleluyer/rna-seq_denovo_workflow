#!/bin/bash
#PBS -A userID
#PBS -N rsem
#PBS -o log.rsem.out
#PBS -e log.rsem.err
#PBS -l walltime=02:00:00
#PBS -M userEmail
#PBS -m ea 
#PBS -l nodes=1:ppn=8
#PBS -r n

TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#pre-requis
module load compilers/gcc/4.8
module load apps/mugqic_pipeline/2.1.1

#Global variables
TRANSCRIPTOME="05_trinity_assembly/Trinity.fasta"
INFOFILE=""

# Move to job submission directory
cd $PBS_O_WORKDIR

#  Required:

transcriptome=" --trinity_fasta $TRANSCRIPTOME"        	#Trinity fasta file

infosamples="--samples_file $INFOFILE"        		#tab-delimited text file indicating biological replicate relationships.
                                   			#ex.
                                      #	cond_A    cond_A_rep1    A_rep1_left.fq    A_rep1_right.fq
                                       #	cond_A    cond_A_rep2    A_rep2_left.fq    A_rep2_right.fq
                                       # 	cond_B    cond_B_rep1    B_rep1_left.fq    B_rep1_right.fq
                                       #	cond_B    cond_B_rep2    B_rep2_left.fq    B_rep2_right.fq

                                   # note, Trinity-specific parameter settings should be included in the samples_file like so:
                                   # (only --max_memory is absolutely required, since defaults exist for the other settings)
				# --CPU=6
                                #--max_memory=10G
                                # --seqType=fq
                                #--SS_lib_type=RF

#  Optional:
interactive="-I"                             # Interactive mode, waits between commands.

trinity_utils/util/run_RSEM_from_samples_file.pl $transcriptome $infosamples $interactive 2>&1 | tee 98_log_files/"$TIMESTAMP"_rsem.log


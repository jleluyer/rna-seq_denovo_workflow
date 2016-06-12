$outpref
TIMESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
SCRIPT=$0
NAME=$(basename $0)
LOG_FOLDER="98_log_files"
cp $SCRIPT $LOG_FOLDER/"$TIMESTAMP"_"$NAME"

#move to present directory
cd $SGE_O_WORKDIR

#global variables
INPUTFILE="05_trinity_assembly/Trinity.fasta"
OUTPUTFILE="06_assembly_stats/results_stats.txt"

#Check stats
00_scripts/trinity_utils/util/TrinityStats.pl "$INPUTFILE" > "$OUTPUTFILE" 2>&1 | tee 98_log_files/"$TIMESTAMP"_assemblystats.log


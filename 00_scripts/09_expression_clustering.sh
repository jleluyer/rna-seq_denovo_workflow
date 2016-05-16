#!/bin/bash
#$ -N cluster
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
R_DATA="/path/to/R.data"

# Trinity variables
k_cluster="-K <int>"         # define K clusters via k-means algorithm

#or, cut the hierarchical tree:

#k_tree="--Ktree <int>"     	#cut tree into K clusters

p_tree="--Ptree <float>"	   #cut tree based on this percent of max(height) of tree 

r_data="-R <string $R_DATA" 	#the filename for the store RData (file.all.RData)

# misc:

lexical_order=" --lexical_column_ordering"       #reorder column names according to lexical ordering
#no_order="--no_column_reordering"  


# run clustering
00_scripts/trinity_utils//Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl $k_cluster $k_tree \
			$p_tree $r_data $lexical_order $no_order 2>&1 | tee 98_log_files/"$TIMESTAMP"_cluster.log 

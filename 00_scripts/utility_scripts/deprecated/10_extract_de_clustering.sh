#!/bin/bash
#$ -N cluster_de
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
MATRIX="/path/to/matrix"
SAMPLE_REPLICATE="01_info_files/sample_replicates.txt"

# Trinity variable
matrix="--matrix $MATRIX"       #TMM.EXPR.matrix

# Optional:
p_value="-P 0.001"             #p-value cutoff for FDR  (default: 0.001)
min_log2FC="-C 2"           #min abs(log2(a/b)) fold change (default: 2  (meaning 2^(2) or 4-fold).
output="--output <float>"      #prefix for output file (default: "diffExpr.P${Pvalue}_C${C})

# Misc:
sample_replicate="--samples $SAMPLE_REPLICATE"                    # sample-to-replicate mappings (provided to run_DE_analysis.pl)
max_de_genes="--max_DE_genes_per_comparison 100"    	# extract only up to the top number of DE features within each pairwise comparison.
                                         		# This is useful when you have massive numbers of DE features but still want to make
                                          		# useful heatmaps and other plots with more manageable numbers of data points.
 
order_column="--order_columns_by_samples_file"      	# instead of clustering samples or replicates hierarchically based on gene expression patterns,
                                       		# order columns according to order in the --samples file.
max_gene_clust="--max_genes_clust 10000"            # default: 10000  (if more than that, heatmaps are not generated, since too time consuming)

#go_enrich="--examine_GO_enrichment"                #run GO enrichment analysis
#go_annot="-GO_annots <string>"             # GO annotations file
#gene_len="--gene_lengths float"           #lengths of genes file

# run clustering
00_scripts/trinity_utils/Analysis/DifferentialExpression/analyze_diff_expr.pl $matrix $p_value $min_log2FC \
										$ouput $sample_replicate $max_de_genes $order_column \
										$max_gene_clust $go_enrich $go_annot $gene_len  2>&1 | tee 98_log_files/"$TIMESTAMP"_cluster_de.log 

 


#Required:
meth="--est_method <string>"            #RSEM|eXpress|kallisto  (needs to know what format to expect)

# Options:
norm="--cross_sample_norm TMM"          #TMM|UpperQuartile|none   (default: TMM)
name_dir="--name_sample_by_basedir"     #name sample column by dirname instead of filename
base_dir="--basedir_index -2"           #default(-2)

out_pref="--out_prefix matrix"          #default: 'matrix'

#run estimate to matrix
00_scripts/trinity_utils/util/abundance_estimates_to_matrix.pl $meth $norm $name_dir $base_dir $out_pref sample1.results sample2.results ...

# RNA-seq analysis in de novo

An integrated worklow for *de novo* analysis and DE gene assessment to conduct RNA-seq data analyses

This Workflow is developped in [Louis Bernatchez' lab](https://www.bio.ulaval.ca/louisbernatchez/presentation.htm).

**WARNING**

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.

## Downloading

You can clone this repository with:

```
git clone https://github.com/jleluyer/rna-seq_denovo_workflow
```

## Documentation

### 1. Clone git hub directory

```
git clone https://github.com/jleluyer/rna-seq_denovo_workflow
```

### 2. Prepare utilities

```
cd rna-seq_denovo_workflow

./00_scripts/00_import_trinity.sh
```
This script will create the utilities directories that have to be configured and installed

```
cd 00_scripts/trinity_utils/
make
make plugins
cd ../..
```

```
cd 00_scripts/transdecoder_utils/
make
cd ../..
```

For Corset, small changes need to be done to correctly confgure and install the software. Change **userNAME** for your username.

```
cd 00-scripts/corset_utils
./configure --with-bam_inc=/prg/samtools/0.1.19/ --with-bam_lib=/prg/samtools/0.1.19/ --prefix=/home/userNAME/local
make
make install
cd ../..
```

Make sure **Bowtie** is in your **$PATH**.

### 3. Import data

```
cp /path/to/the/data/repository/*.gz 02_data
```

### 4. Trimming the data

* Import univec.fasta

```
wget 01_info_files/univec.fasta ftp://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec
```
Add your specific adaptors if absent in the database.

* Trimming

Two scripts are provided for **Single-End** or **Paired-end** data, **00_scripts/01_trimmomatic_se.sh** and **00_scripts/01_trimmomatic_pe.sh**, respectively.

```
sbatch 00_scripts/01_trimmomatic_se.sh
```

You may also want to check the quality of your data prior to trimming using **00_scripts/utility_scripts/fastq.sh**. This will require to have **fastQC** installed in your **$PATH**.

### 4. Merging data for assembly

Note: Trinity is memory-consuming, make sure you adapt the number of samples to the memory available. When limited in memory, you could use a in silico normalization provided in the **00_scripts/utility_scripts/insilico_normalization.sh**. Otherwise, you may want to select a subset of the data and modify **./00_scripts/02_merge.sh**. For more information regarding memory usage, please visit [Trinity memory usage](http://trinityrnaseq.github.io/performance/mem.html) 

```
sbatch 00_scripts/02_merge.sh
```

### 5. Assembly

Before running assembly, you need to make sure that the folder **05_trinity_assembly** is empty.
You also need to adapt the script for your own needs. For instance, you will need to adapt the input files (either SE, PE or strand-specific) in the global variables section. Other parameters need also to be carefuly chosen (_e.g_: minimum length of transcripts, ...).

```
sbatch 00_scripts/03_assemble.sh
```

### 6. Check assembly quality

```
sbatch 00_scripts/04_assembly_stats.sh
```
This script will output file **06_assembly_stats/results_stats.txt**

Other scripts are provided to assess the quality of the transcriptome:
**00_scripts/utility_scripts/assessing_read_content.sh**


### 7. Downstream analysis

#### 7.1 Transcript abundance

* Prepare reference

```
sbatch 00_scripts/05_prep_ref.sh
```

* Quantify transcripts abundance

```
sbatch 00_scripts/06_transcripts_abundance.sh
```

Several options are possible ase well as severel tools for quantifying trasncripts aboundance such as **RSEM**, **Kallisto**, **eXpress** or **salmon** as well as different aligners **Bowtie** or **Bowtie2**

* Cluster transcripts

```
sbatch 00_scripts/utilities/corset.sh
```

### 7.2 Annotation

* Predict longest ORFs

```
sbatch 00_scripts/utility_scripts/transdecoder_getorfs.sh
```

* Blast against Uniprot

```
sbatch 00_scripts/utility_scripts/blastp.sh
```
_note: you will need access to **uniprot_sprot.fasta** database_


* Identify protein families

```
sbatch 00_scripts/utility_scripts/pfam.sh
```
_note: you will need access to **Pfam-A** database_


* Identify signal peptides

```
sbatch 00_scripts/utility_scripts/signalip.sh
```
_need to install signalip_

* Identify transmembrane regions

```
sbatch 00_scripts/utility_scripts/tmhmm.sh
```
_need to install tmhmm_

* Identify rRNA transcripts

```
sbatch 00_scripts/utility_scripts/rnammer.sh
```
_need to install rnammer_

* Compile the annotation in a final report

```
sbatch 00_scripts/utility_scripts/trianotate.sh
```

_note: you will need access to **Trinotate.sqlite** database_


### 7.3 Differential expression analysis


* Build transcripts expression matrices

```
sbatch 00_scripts/07_matrix.sh
```
* running DE
```
sbatch 00_scripts/08_de_analysis.sh
```

Several packages are available and implemented in the script such as **DeSeq2**, **Lima/voom**, **EdgeR** and **ROTS**.


## Notes

## Dependencies

### Softwares

[Trinity](https://github.com/trinityrnaseq/trinityrnaseq)

[Trinotate](https://github.com/Trinotate/Trinotate)

[RSEM](https://github.com/deweylab/RSEM)

[Bowtie](http://bowtie-bio.sourceforge.net/index.shtml)

**java 1.7** or higher

[R](https://www.r-project.org/)

### R packages

[edgeR](http://bioconductor.org/packages/release/bioc/html/edgeR.html)

[DESeq2](http://bioconductor.org/packages/release/bioc/html/DESeq2.html)

[limma/voom](http://bioconductor.org/packages/release/bioc/html/limma.html)

[ROTS](http://www.btk.fi/research/research-groups/elo/software/rots/)

[goseq](http://www.bioconductor.org/packages/release/bioc/html/goseq.html)

#### Install R packages

```R
%R
source("http://bioconductor.org/biocLite.R")
biocLite('edgeR')
biocLite('limma')
biocLite('DESeq2')
biocLite('ctc')
biocLite('Biobase')
bioclite("goseq")
install.packages('gplots')
install.packages('ape')
```

## Citations

Grabherr MG, Haas BJ, Yassour M, Levin JZ, Thompson DA, Amit I, Adiconis X, Fan L, Raychowdhury R, Zeng Q, Chen Z, Mauceli E, Hacohen N, Gnirke A, Rhind N, di Palma F, Birren BW, Nusbaum C, Lindblad-Toh K, Friedman N, Regev A. (2011). Full-length transcriptome assembly from RNA-seq data without a reference genome. **_Nat. Biotechnol._** [doi: 10.1038/nbt.1883](http://www.ncbi.nlm.nih.gov/pubmed/21572440)

Haas BJ, Papanicolaou A, Yassour M, Grabherr M, Blood PD, Bowden J, Couger MB, Eccles D, Li B, Lieber M, Macmanes MD, Ott M, Orvis J, Pochet N, Strozzi F, Weeks N, Westerman R, William T, Dewey CN, Henschel R, Leduc RD, Friedman N, Regev A. (2013). De novo transcript sequence reconstruction from RNA-Seq: reference generation and analysis with Trinity. **_Nat. Protoc._** [doi:  10.1038/nprot.2013.084](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3875132/)

[Trinity documentation](https://github.com/trinityrnaseq/trinityrnaseq/wiki)

## Licence

The rna-seq_denovo_workflow is licensed under the GPL3 license. See the LICENCE file for more details.

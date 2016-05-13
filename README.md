# RNA-seq analysis in de novo

An integrated worklow for *de novo* analysis and DE gene assessment to conduct RNA-seq data analyses

## Documentation

[**Documentation**](https://github.com/jleluyer/rNA-seq_denovo_mapping)

## Citations

Grabherr MG, Haas BJ, Yassour M, Levin JZ, Thompson DA, Amit I, Adiconis X, Fan L, Raychowdhury R, Zeng Q, Chen Z, Mauceli E, Hacohen N, Gnirke A, Rhind N, di Palma F, Birren BW, Nusbaum C, Lindblad-Toh K, Friedman N, Regev A. (2011). Full-length transcriptome assembly from RNA-seq data without a reference genome. **_Nat. Biotechnol._** [doi: 10.1038/nbt.1883](http://www.ncbi.nlm.nih.gov/pubmed/21572440)

Haas BJ, Papanicolaou A, Yassour M, Grabherr M, Blood PD, Bowden J, Couger MB, Eccles D, Li B, Lieber M, Macmanes MD, Ott M, Orvis J, Pochet N, Strozzi F, Weeks N, Westerman R, William T, Dewey CN, Henschel R, Leduc RD, Friedman N, Regev A. (2013). De novo transcript sequence reconstruction from RNA-Seq: reference generation and analysis with Trinity. **_Nat. Protoc._** [doi:  10.1038/nprot.2013.084](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3875132/)

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

```R
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

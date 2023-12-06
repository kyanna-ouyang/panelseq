# panelseq
Pipeline for finding variants in panel genes from WES data of patient-derived organoids (but can also be applied for general variant calling from WES data of patient tissues and organoids and from WGS data of bacterial and fungal isolates)

Purpose of panelseq:
- Quick and cheap way to check mutations in organoid cultures
- Investigate genetic drift in organoid cultures

Steps: 
1. create meta file (Bash): create a file with sample names to be prefixes of all files to be created and to be used in while loops
2. BWA mapping (Bash): map reads to reference genome (input: fastq --> output: sam)
3. SAMtools convert and index (Bash): convert to, sort and index bam files (input: sam --> output: bam and bai)
4. Strelka2 variant calling (Bash): call variants against healthy sample (input: bam and bai --> output: vcf)
5. SnpEff variant effect prediction (Bash): annotate variants for effect, type and severity (input: vcf --> output: vcf)
6. BCFtools vcf manipulation (Bash): extract desired information about variants (input: vcf --> output: tsv)
7. Calculate allele frequency (custom R code)
8. Annotate variants with Biomart (custom R code)
9. Alternative to step 8: Annotate variants with annotation file (custom R code)

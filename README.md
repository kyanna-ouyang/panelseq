# panelseq
Pipeline for finding variants in panel genes

Purpose:
- Quick and cheap way to check mutations in organoid cultures
- Investigate genetic drift in organoid cultures

Steps: 
1. create meta file (Bash): create a file with sample names to be prefixes of all files to be created and to be used in while loops
2. bwa mapping (Bash): map reads to reference genome (input: fastq --> output: sam)
3. samtools convert and index (Bash): convert to, sort and index bam files (input: sam --> output: bam and bai)
4. strelka variant calling (Bash): call variants against normal sample (input: bam and bai --> output: vcf)
5. vcf analysis (Bash): extract desired information about variants (input: vcf --> output: tsv)
6. biomart variant analysis (R): add gene names (input: tsv --> output: tsv)
7. allele frequency: how to calculate frequency of specific variant alleles

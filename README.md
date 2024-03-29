# panelseq
Pipeline for finding single nucleotide and insertion/deletion variants in panel genes from WES data of patient-derived organoids (but can also be applied for general variant calling from WES data of patient tissues and organoids and from WGS data of bacterial and fungal isolates)

Purpose of panelseq:
- Quick and cheap way to check mutations in organoid cultures
- Investigate genetic drift in organoid cultures

Steps: 
1. Create index file (Bash or text editor): create a file with sample names or fastq IDs to be prefixes of all files to be created and to be used in while loops
2. BWA-mem2 mapping (Bash): map reads to reference genome (input: fastq --> output: sam)
3. SAMtools convert and index (Bash): convert to, sort and index bam files (input: sam --> output: bam and bai)
4. Strelka2 variant calling (Bash): call variants against healthy sample (input: bam and bai --> output: vcf)
5. SnpEff variant effect prediction (Bash): annotate variants for effect, type and severity (input: vcf --> output: vcf)
6. BCFtools VCF manipulation (Bash): extract desired information about variants (input: vcf --> output: tsv)
7. Calculate allele frequency and annotate variants with biomaRt (custom R code)
8. Alternative to 7: Calculate allele frequency and annotate variants with annotation file (custom R code)

Links to documentation of tools used
- BWA-mem2: https://github.com/bwa-mem2/bwa-mem2
- SAMtools: https://www.htslib.org/doc/
- Strelka2: https://github.com/Illumina/strelka
- SnpEff: https://pcingola.github.io/SnpEff/
- BCFtools: https://samtools.github.io/bcftools/bcftools.html
- biomaRt: https://bioconductor.org/packages/release/bioc/html/biomaRt.html

Note on BWA-mem2 (v2.2.1)
- Potential error with BWA-mem2 installation: only some modes (e.g. sse41 and sse42) are executable
- Solution: manually specify to use one of the executable modes
  
Useful links for BCFtools
- https://eriqande.github.io/eca-bioinf-handbook/basic-handling-of-vcf-files.html
- https://en.wikipedia.org/wiki/Variant_Call_Format

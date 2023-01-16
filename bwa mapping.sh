# bwa mapping

# installing bwa-mem2
wget https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.2.1/bwa-mem2-2.2.1_x64-linux.tar.bz2
tar xvjf bwa-mem2-2.2.1_x64-linux.tar.bz2

# error: only sse41 and sse42 modes are executable
# attempted solution: https://github.com/bwa-mem2/bwa-mem2/issues/73
# result: just manually specify to use sse42 mode

# indexing reference sequence (requires 28N GB memory where N is the size of the reference sequence)
# --> created GRCh38.primary_assembly.genome.fa.0123, .amb, .ann, .bwt.2bit.64 and .pac files

bsub -q verylong -R "rusage[mem=84G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 index GRCh38.primary_assembly.genome.fa"

# indexing with original bwa --> created GRCh38.primary_assembly.genome.fa.bwt and GRCh38.primary_assembly.genome.fa.sa files

bsub -q verylong -R "rusage[mem=84G]" "/software/bwa/0.7.8/bin/bwa index GRCh38.primary_assembly.genome.fa"

# single-end mapping (run ./bwa-mem2 mem to get all options)

bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL10T-hC1-r1_S5_L001_R1_001.fastq > EL10T-hC1-r1_S5_L001_R1_001.sam"

# paired-end mapping

bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8N-blood_S10_L001_R1_001.fastq EL8N-blood_S10_L001_R2_001.fastq > EL8N-blood_S10_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-hC1-s1_S4_L001_R1_001.fastq EL8T-hC1-s1_S4_L001_R2_001.fastq > EL8T-hC1-s1_S4_L001.aln-pe.sam"

bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL10T-hC1-r1_S5_L001_R1_001.fastq EL10T-hC1-r1_S5_L001_R2_001.fastq > EL10T-hC1-r1_S5_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL2T-organoids_S1_L001_R1_001.fastq EL2T-organoids_S1_L001_R2_001.fastq > EL2T-organoids_S1_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8N-p0_S3_L001_R1_001.fastq EL8N-p0_S3_L001_R2_001.fastq > EL8N-EL8N-p0_S3_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8N-tissue_S8_L001_R1_001.fastq EL8N-tissue_S8_L001_R2_001.fastq > EL8N-tissue_S8_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-hC1-s2_S6_L001_R1_001.fastq EL8T-hC1-s2_S6_L001_R2_001.fastq > EL8T-hC1-s2_S6_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-in1-s1_S7_L001_R1_001.fastq EL8T-in1-s1_S7_L001_R2_001.fastq > EL8T-in1-s1_S7_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-in1-s2_S9_L001_R1_001.fastq EL8T-in1-s2_S9_L001_R2_001.fastq > EL8T-in1-s2_S9_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-out2-s1_S11_L001_R1_001.fastq EL8T-out2-s1_S11_L001_R2_001.fastq > EL8T-out2-s1_S11_L001.aln-pe.sam"
bsub -q verylong -R "rusage[mem=50G]" "/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux/bwa-mem2.sse42 mem -t 16 /omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/GRCh38.primary_assembly.genome.fa EL8T-tissue_S2_L001_R1_001.fastq EL8T-tissue_S2_L001_R2_001.fastq > EL8T-tissue_S2_L001.aln-pe.sam"

# check distribution of bwa alignments with Integrative Genomics Viewer --> may have to increase stringency (should only cover about 500 areas = 50 genes x 10 reads per gene)
# transfer bam and bai files to local directory

while read i; do
	rsync k545g@bsub01.lsf.dkfz.de:/omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/${i}_L001.aln-pe.sorted.bam .
	rsync k545g@bsub01.lsf.dkfz.de:/omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/${i}_L001.aln-pe.sorted.bam.bai .
done < samples.txt

rsync k545g@bsub01.lsf.dkfz.de:/omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/EL8T-tissue_S2_L001.aln-pe.sorted.bam .
rsync k545g@bsub01.lsf.dkfz.de:/omics/groups/OE0554/internal/EMIL/Kyanna/strelkatrial/EL8T-tissue_S2_L001.aln-pe.sorted.bam.bai .
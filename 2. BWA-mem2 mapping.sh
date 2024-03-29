# run in Bash

# define variables
bwaPath="/omics/groups/OE0554/internal/EMIL/Kyanna/bwa/bwa-mem2-2.2.1_x64-linux"
refPath="SET"
fastqPath="SET"
outPath="SET"
wkdir="SET"

# index reference sequence (requires 28*N GB memory where N = reference sequence size)
bsub -q long -R "rusage[mem=84G]" "$bwaPath/bwa-mem2.sse42 index $refPath/GRCh38.primary_assembly.genome.fa"

# paired-end mapping of all samples against reference genome
while read i; do
bsub -q long -R "rusage[mem=50G]" "$bwaPath/bwa-mem2.sse42 mem -t 16 $refPath/GRCh38.primary_assembly.genome.fa $fastqPath/${i}_L001_R1_001.fastq $fastqPath/${i}_L001_R2_001.fastq > $outPath/${i}.aln-pe.sam"
done < $wkdir/ids

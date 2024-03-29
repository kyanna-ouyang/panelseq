# run in Bash

# set variables
refPath="SET"
wkdir="SET"

# index reference genome
bsub -q long -R "rusage[mem=50G]" "/software/samtools/1.9/bin/samtools faidx $refPath/GRCh38.primary_assembly.genome.fa"

# convert SAM files to BAM files
while read i; do
/software/samtools/1.9/bin/samtools view -S -b ${i}.aln-pe.sam > ${i}.aln-pe.bam
done < $wkdir/ids

# sort BAM files
while read i; do
/software/samtools/1.9/bin/samtools sort ${i}.aln-pe.bam -o ${i}.aln-pe.sorted.bam
done < $wkdir/ids

# index BAM files
while read i; do
/software/samtools/1.9/bin/samtools index ${i}.aln-pe.sorted.bam ${i}.aln-pe.sorted.bam.bai
done < $wkdir/ids

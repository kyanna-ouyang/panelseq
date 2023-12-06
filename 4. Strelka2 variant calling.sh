# run in Bash

# set variables
wkdir="SET"
STRELKA_INSTALL_PATH="/omics/groups/OE0554/internal/EMIL/Kyanna/strelka/strelka-2.9.10.centos6_x86_64" \
refFasta="SET"
normalID="SET" #index of normal sample

# Strelka2 somatic workflow configuration
while read i; do
mkdir results_${i}
STRELKA_ANALYSIS_PATH="$wkdir/results_${i}"
normal_BAM="$wkdir/$normalID.aln-pe.sorted.bam"
test_BAM="$wkdir/${i}.aln-pe.sorted.bam"
${STRELKA_INSTALL_PATH}/bin/configureStrelkaSomaticWorkflow.py \
--normalBam $normal_BAM \
--tumourBam $test_BAM \
--referenceFasta $refFasta \
--runDir $STRELKA_ANALYSIS_PATH \
done < $wkdir/ids

# Strelka2 execution
while read i; do
bsub -q long -R "rusage[mem=50G]" "$wkdir/results_${i}/runWorkflow.py -m local -j 8"
done < $wkdir/ids

# unzip vcf files
while read i; do
gunzip -c $wkdir/results_${i}/results/variants/somatic.indels.vcf.gz > $wkdir/results_${i}/results/variants/somatic.indels.vcf
gunzip -c $wkdir/results_${i}/results/variants/somatic.snvs.vcf.gz > $wkdir/results_${i}/results/variants/somatic.snvs.vcf
done < $wkdir/ids

# move all vcf files to one folder
while read i; do
mv $wkdir/results_${i}/results/variants/somatic.indels.vcf $wkdir/results/${i}.somatic.indels.vcf
mv $wkdir/results_${i}/results/variants/somatic.snvs.vcf $wkdir/results/${i}.somatic.snvs.vcf
done < $wkdir/ids

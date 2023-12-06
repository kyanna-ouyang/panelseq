# set variables
wkdir="SET"
snpEffPath="/omics/groups/OE0554/internal/EMIL/Kyanna/snpEff"
refDB="SET" #name of reference database (e.g. GRCh38.p14)

# run SnpEff
while read i; do
bsub -q long -R "rusage[mem=50G]" "java -Xmx8g -jar $snpEffPath/snpEff.jar -v -stats $wkdir/${i}.snvs.html $refDB $wkdir/results/${i}.somatic.snvs.vcf > $wkdir/${i}.somatic.snvs.ann.vcf"
done < $wkdir/ids

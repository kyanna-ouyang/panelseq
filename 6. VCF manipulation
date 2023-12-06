# run in Bash

# set variables
wkdir="SET"

# extract chrom, pos, ref, alt, qual and filter values
while read i; do
/software/bcftools/1.16/bin/bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%FILTER\n' $wkdir/${i}.somatic.snvs.vcf > $wkdir/${i}.snvs.tsv
/software/bcftools/1.16/bin/bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%FILTER\n' $wkdir/${i}.somatic.indels.vcf > $wkdir/${i}.indels.tsv
done < $wkdir/ids

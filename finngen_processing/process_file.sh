#!/bin/bash

SSFILE=$1

echo "Downloading summary statistics..."
wget https://storage.googleapis.com/finngen-public-data-r12/summary_stats/release/$SSFILE &> /dev/null

echo "Changing to hg19 coordinates"
zcat $SSFILE | tail -n +2 | awk -F '\t' 'OFS="\t" { if ($5=="") { $5="NA" } ; print "chr"$1,$2-1,$2,$5,$7 }' > ${SSFILE%%.gz}.src.bed
/mnt/data/phenome_proj/finngen/liftOver ${SSFILE%%.gz}.src.bed /mnt/data/phenome_proj/finngen/hg38ToHg19.over.chain ${SSFILE%%.gz}.out.bed ${SSFILE%%.gz}.unmap.bed
awk 'OFS="\t" { if (NR==1) { print "SNP\tChr\tPos\tP" } print $4,$1,$3,$5 }' ${SSFILE%%.gz}.out.bed  | perl -pe 's|\tchr|\t|' > ${SSFILE%%.gz}.plink.tsv

echo "Running clumping"
~/software/plink --bfile /mnt/data/phenome_proj/EUR_005_nodups --clump ${SSFILE%%.gz}.plink.tsv --out ${SSFILE%%.gz}.clump --clump-r2 0.1 --clump-p1 1e-8 --clump-p2 1e-4 --clump-field P --allow-no-sex --allow-extra-chr

# Cleanup
echo "Performing final cleanup"
rm $SSFILE ${SSFILE%%.gz}.src.bed ${SSFILE%%.gz}.out.bed ${SSFILE%%.gz}.unmap.bed ${SSFILE%%.gz}.plink.tsv

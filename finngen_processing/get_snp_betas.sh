#!/bin/bash

SSFILE=$1

echo "Downloading summary statistics..."
wget https://storage.googleapis.com/finngen-public-data-r12/summary_stats/release/$SSFILE &> /dev/null

echo "Changing to hg19 coordinates"
zcat $SSFILE | awk '{ if ($11 > 0.05 && $11 < 0.95) print }' | cut -f 5,9,10 | gzip -c - > ${SSFILE%%.gz}.flt.gz
rm $SSFILE

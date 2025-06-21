#!/bin/bash

# ls -lh ../clumping/*clumped | grep -oP 'finngen_[^\.]+' | perl -pe 's|$|.flt.gz|' > clumped_traits.list
FILE_LIST=$1

if [ -f snp.list ]; then
	echo "Removed existing SNP list"
	rm snp.list
fi

for trfile in $( cat $FILE_LIST )
do
	echo "Processing file $trfile"
	zcat $trfile | cut -f 1 | sort | uniq -c | awk '{ if ($1 == 1) print $2 }' >> snp.list
done

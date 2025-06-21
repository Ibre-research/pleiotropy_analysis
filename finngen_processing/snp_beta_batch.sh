#!/bin/bash

for i in $( cat filenames.list )
do
	echo "Processing $i"
	./get_snp_betas.sh $i
done

#!/bin/bash

for i in $( cat filenames.list )
do
	echo "Processing $i"
	./process_file.sh $i
done

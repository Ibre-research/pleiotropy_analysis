#!/bin/bash

# Human genome
zcat gencode.v19.annotation.gtf.gz | grep -vP '^#' | grep -P '\tgene\t' | cut -f 1,4,5,9 | perl -pe 's|\t[^\t]+gene_name \"|\t|' | perl -pe 's|\".*||' | perl -pe 's|^chr||' | awk 'OFS="\t" { $2=$2-1; print }' > gencode.v19.genes.bed

# Mouse genome
zcat gencode.vM37.annotation.gtf.gz | grep -vP '^#' | grep -P '\tgene\t' | cut -f 1,4,5,9 | perl -pe 's|\t[^\t]+gene_name \"|\t|' | perl -pe 's|\".*||' | perl -pe 's|^chr||' | awk 'OFS="\t" { $2=$2-1; print }' > gencode.vM37.genes.bed

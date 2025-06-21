#!/usr/bin/env python

import re
import sys
import gzip
from collections import defaultdict

snplist = sys.argv[1]
trait_file_list = sys.argv[2]
trait_files = []
with open(trait_file_list, 'r') as tlfile:
    for line in tlfile:
        trait_files.append(line.strip())
n_traits = len(trait_files)

variants = defaultdict(lambda: 0)
line_counter = 0
with open(snplist, 'r') as snp_file:
    for line in snp_file:
        variants[line.strip()] += 1
        line_counter += 1
        if (line_counter % 10000000 == 0):
            print(f'Processed {line_counter} lines')

core_set = set()
for variant, trait_count in variants.items():
    if trait_count == n_traits:
        core_set.add(variant)
print(f'Constructed SNP core set containing {len(core_set)} variants')

# Remember - the file should exist
# May be we should add downloading here as well
with gzip.open(trait_files[0].replace('.flt', ''), 'rt') as stat_handle, open('alleles.txt', 'w') as alleles_handle:
    alleles_handle.write('rsID,allele_0,allele_1\n')
    for line in stat_handle:
        content = line.strip().split('\t')
        try:
            alt_af = float(content[10])
        except:
            continue
        if alt_af < 0.05 or alt_af > 0.95:
            continue
        if content[4] in core_set:
            alleles_handle.write(f'{content[4]},{content[2]},{content[3]}\n')
print(f'Exported allele information')

for trait_file in trait_files:
    print(f'Processing file {trait_file}')
    with gzip.open(trait_file, 'rt') as ss_handle, open(trait_file.replace('flt.gz', '.beta'), 'w') as of_handle:
        trait_name = re.findall('finngen_R12_([^\.]+)', trait_file)[0].replace('_', '.')
        of_handle.write(f'{trait_name}_b,{trait_name}_se\n')
        for line in ss_handle:
            content = line.strip().split('\t')
            if content[0] in core_set:
                of_handle.write(f'{content[1]},{content[2]}\n')



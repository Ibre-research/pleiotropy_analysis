# Patterns of pleiotropy in Mendelian and complex traits

![A model of pleiotropic effects of genetic variants](model.png)

This repository contains all code and data pertinent to the analyiss of functional and evolutionary patterns of pleiotropy across multiple several large-scale mammalian datasets (Human Phenotype Ontology (HPO), Mouse Genome Database (MGD), pan-UK Biobank (panUKB)). The results of the analysis are presented in the following paper:

Barbitoff, Y.A., Bogaichuk, P.M., Pavlova, N.S., and Predeus, A.V. (2024) Unique functional and evolutionary patterns of pleiotropy in complex and Mendelian traits. *bioRxiv* doi: 10.XXXX/XXXXX.

## Prerequisites

To run the analysis pipeline, you will need Python >= 3.10 and R >= 4.3. To set up the environment with all of necessary packages, please use the provvided environemnt file. 

## Repository contents

`final_analysis.Qmd` - the main analysis file used to generate all figures and comparisons presented in the article;

`updated_general_HPO_table.tsv` - the main merged data file used for final anaalysis,

`preliminary_analysis.ipynb` - the preliminary analysis file that was used to construct the merged dataset from all sources;

`databases` - a folder containing individual data files used to construct the merged dataset;

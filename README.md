# Amino Base Mapping (ABM)

## Requirements

EMBOSS  
sudo apt install emboss
  
SRA-Toolkit  
sudo apt install sra-toolkit

## How To Use

Allow file to execute as a program for :
- ABM_Detection.sh
- ABM_Mapping.sh
- revtrans.py
- search_pep.out

### Peptide Mapping

-Copy the studied genome into the Genome folder (.fasta)  
Compatible with : - Ensembl genome

-Run ABM_Mapping.sh with option -i as such :  
sh ABM_Mapping.sh -i [peptide sequence]  
Example : sh ABM_Mapping.sh -i VRIKPGSA  

-Result in the Output/peptide_localisation.txt

### Peptide Detection
**Currently, Peptide Detection is limited to organisms with a genetic code similar to humans**

-Go to https://www.ncbi.nlm.nih.gov/sra

-Create specific request.  
Request example : "embryo[All Fields] AND (stem cells[All Fields] OR stem cell[All Fields]) AND transcriptome[All Fields] AND embryonic[All Fields] AND analysis[All Fields] AND "Homo sapiens"[Organism] AND ("biomol rna"[Properties] AND "library layout single"[Properties] AND "filetype fastq"[Properties])"  

More info : https://www.ncbi.nlm.nih.gov/sra/docs/srasearch/

-Download SRA run IDs as "Runinfo"

-Run ABM_Detection.sh with options -i and -r as such :  
sh ABM_Detection.sh -i [peptide sequence] -r [path_to_Runlist] -k(optional)  

Example : sh ABM_Detection.sh -i VRIKPGSA -r Run_id.csv -k  
sh ABM_Detection.sh -h for more info  

-Result in the Output/transcriptome_result.txt

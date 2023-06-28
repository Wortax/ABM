## Requirements

EMBOSS
sudo apt install emboss

SRA-Toolkit
sudo apt install sra-toolkit

##Configuration

###Peptide Mapping

Copy the studied genome into the Genome folder (.fasta)
Compatible with : - Ensembl genome

Edit the peptide.txt to add your peptide amino acid sequence

Run ABM_Mapping.sh

Result in the Output/peptide_localisation.txt

###Peptide Detection

Download SRA run IDs from NCBI SRA website into the SRR_id folder

Run ABM_DL_and_Analysis.sh

Result in the Output/transcriptome_result.txt

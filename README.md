## Requirements

EMBOSS
sudo apt install emboss

SRA-Toolkit
sudo apt install sra-toolkit

## Configuration

### Peptide Mapping

Copy the studied genome into the Genome folder (.fasta)
Compatible with : - Ensembl genome

Edit the peptide.txt to add your peptide amino acid sequence

Run ABM_Mapping.sh

Result in the Output/peptide_localisation.txt

### Peptide Detection

Go to https://www.ncbi.nlm.nih.gov/sra

Create specific request.  
Request example : "embryo[All Fields] AND (stem cells[All Fields] OR stem cell[All Fields]) AND transcriptome[All Fields] AND embryonic[All Fields] AND analysis[All Fields] AND "Homo sapiens"[Organism] AND ("biomol rna"[Properties] AND "library layout single"[Properties] AND "filetype fastq"[Properties])"  

More info : https://www.ncbi.nlm.nih.gov/sra/docs/srasearch/

Download SRA run IDs as "Runinfo" and move it into the SRR_id folder

Edit the peptide.txt to add your peptide amino acid sequence

Run ABM_DL_and_Analysis.sh

Result in the Output/transcriptome_result.txt

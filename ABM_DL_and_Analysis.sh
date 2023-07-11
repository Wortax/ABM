rm Output/transcriptome_result.txt 2> /dev/null
rm Temp/transcriptome_result.txt 2> /dev/null
cd Transcriptome

while IFS=, read -r srr_id b; do
	if [ $srr_id = "Run" ];
	then continue
	fi
    	echo "Downloading: $srr_id"
	fastq-dump --fasta 0 --skip-technical $srr_id || continue
	echo
	grep -v ">" $srr_id.fasta  | head -n 3
	echo
	
	peptide="$(cat ../peptide.txt)"
	reg_pep="$(python3 ../revtrans.py $peptide)"
	echo Searching $peptide in $srr_id :
	result=$(grep -v ">" $srr_id.fasta | grep -E -c $reg_pep );
	echo $result
	echo
	echo "$srr_id\t$result">> ../Temp/transcriptome_result.txt;

	rm -rf $srr_id.fasta
done < ../SRR_id/*.csv
	
cd ..
cat Temp/transcriptome_result.txt > Output/transcriptome_result.txt
cat Output/transcriptome_result.txt

echo "Press enter to close... "
read temp

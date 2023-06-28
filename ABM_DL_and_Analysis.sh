rm Output/transcriptome_result.txt || :
cd Transcriptome
rm -rf 	*
while IFS= read -r srr_id; do
    	echo "Downloading: $srr_id"
	fastq-dump $srr_id
	echo
	echo Spliting...
	split -b 1G $srr_id.fastq "$srr_id"_
	rm $srr_id.fastq
	
	peptide="$(cut -f4 ../Output/pep_localisation.txt)"
	echo Searching $peptide in Files :
	echo
	result="0" 
	for FILE in * ;do echo -$FILE ;result=$(cat $FILE | tr -cd 'ATCG' |LC_ALL=C fgrep -z -o $peptide | grep -c $peptide);
	a=$(echo $FILE | cut -d/ -f2 | cut -d_ -f1);
	echo "$a\t$result" >> ../Temp/transcriptome_result.txt;
	echo; done
	echo
	echo
	rm -rf 	*
done < ../SRR_id/Run_id.txt
	
cd ..
cat Temp/transcriptome_result.txt | awk '{ a[$1]+=$2 }END{ for(i in a) print i,a[i] }' | sort -k 2 -r > Output/transcriptome_result.txt
rm -rf 	Temp/transcriptome_result.txt || :
echo "Press enter to close... "
read temp


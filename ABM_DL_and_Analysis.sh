rm Output/transcriptome_result.txt 2> /dev/null
rm Temp/transcriptome_result.txt 2> /dev/null
keep=$false

while getopts "hi:r:k" option; do
    case $option in
           h) # display Help 
              echo "Commands :\n-i	Input of the peptide amino acid sequence\n-r	Run IDs list path\n-k	Keep downloaded transcriptomes\n-h	Display this message"
              return
              exit;;         
           \?) # incorrect option
              echo "Error: Invalid option"
              return    
              exit;;          
           i) peptide=${OPTARG};;
           r) runlist=${OPTARG};;
           k) # keep option
              keep=$true
              echo "Keeping Downloaded transcriptomes"
              exit;; 
    esac
done
if [ -z "$peptide" ];
then echo "no input peptide"
     return
fi
if [ -z "$runlist" ];
then echo "no Run IDs list"
     return
fi

echo "Searching $peptide in Runlist"
while IFS=, read -r srr_id b; do
	if [ $srr_id = "Run" ];
	then continue
	fi
	echo
    	echo "Downloading: $srr_id"
	fastq-dump --fasta 0 --skip-technical --outdir Transcriptome/ $srr_id || continue
	echo
	grep -v ">" $srr_id.fasta  | head -n 3
	echo
	
	#peptide="$(cat ../peptide.txt)"
	reg_pep="$(python3 ../revtrans.py $peptide)"
	echo Searching $peptide in $srr_id :
	result=$(grep -v ">" Transcriptome/$srr_id.fasta | grep -E -c $reg_pep );
	echo $result
	echo
	echo "$srr_id\t$result">> Temp/transcriptome_result.txt;
	
	if [ !$keep ]
	then rm -rf Transcriptome/$srr_id.fasta
	fi
done < $runlist
	
cat Temp/transcriptome_result.txt > Output/transcriptome_result.txt
cat Output/transcriptome_result.txt

echo "Press enter to close... "
read temp

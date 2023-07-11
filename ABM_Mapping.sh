while getopts "hi:" option; do
    case $option in
           h) # display Help 
              echo "Commands :\n-i	Input of the peptide amino acid sequence\n-h	Display this message"
              return
              exit;;         
           \?) # incorrect option
              echo "Error: Invalid option"
              return    
              exit;;          
           i) peptide=${OPTARG};;

    esac
done
if [ -z "$peptide" ];
then echo "no input peptide"
     return
fi


cd Genome
rm -rf 	..Output/pep_localisation.txt || :

for FILE in * ;do transeq $FILE ../Temp/$FILE.pep -frame=6; ../search_pep.out -p $peptide; rm ../Temp/*; echo ; done
echo
cd ..

peptide_seq="None"
[ -r Output/pep_localisation.txt ] && cat Output/pep_localisation.txt && peptide_seq="$(cut -f4 Output/pep_localisation.txt)" || echo No Match
echo 


echo
echo "Elapsed time: $elapsed s (~"$((elapsed/60))"m) "
echo
echo "Press enter to close... "
read temp

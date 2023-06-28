start_time="$(date -u +%s)"

cd Genome
rm -rf 	../Temp/* || :
rm -rf 	..Output/pep_localisation.txt || :
for FILE in * ;do transeq $FILE ../Temp/$FILE.pep -frame=6; ../search_pep.out; rm ../Temp/*; echo ; done
echo
cd ..

peptide="None"
[ -r Output/pep_localisation.txt ] && cat Output/pep_localisation.txt && peptide="$(cut -f4 Output/pep_localisation.txt)" || echo No Match
echo 


end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
echo
echo "Elapsed time: $elapsed s (~"$((elapsed/60))"m) "
echo
echo "Press enter to close... "
read temp

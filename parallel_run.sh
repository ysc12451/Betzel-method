mkdir -p /storage08/shuchen/output1127

ls /storage08/shuchen/temp1127 | parallel -j 3 \
 P={}; matlab -nodisplay -nosplash -nodesktop -r "filename='$P';test1127;quit" > /storage08/shuchen/output1127/{}.txt
  
for dirname in $(ls /storage08/shuchen/temp1127); do
  filename=/storage08/shuchen/temp1127/${dirname};
  echo ${filename}
done > /storage08/shuchen/parallel_dirs.txt

for P in $(cat /storage08/shuchen/parallel_dirs.txt); do
  matlab -nodisplay -nosplash -nodesktop -r "fprintf($P); quit;";
done > parallel_output.txt


matlab -nodisplay -nosplash -nodesktop -r "disp($P); quit;";

for P in $(cat /storage08/shuchen/parallel_dirs.txt); do
  matlab -nodesktop -nosplash -r "filename='$P';test1127;quit"
done > parallel_output.txt


doit(){
  P=$1
  # echo $P
  part1=$(echo $P | cut -d'/' -f5);
  part2=$(echo $P | cut -d'/' -f7);
  outfile=${part1}_${part2};
  echo $outfile;
  matlab -nodesktop -nosplash -r "filename='$P';run_Betzel;quit" > /storage08/shuchen/output/$outfile.txt
}

export -f doit

date; parallel -j 27 doit :::: /storage08/shuchen/filepaths.txt; date;

head -n 1 /storage08/shuchen/filepaths.txt | doit 

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
  outfile=$(echo $P | cut -d'/' -f5);
  matlab -nodesktop -nosplash -r "filename='$P';test1127;quit" > /storage08/shuchen/output1127/$outfile.txt
}

export -f doit

date; parallel -j 3 doit :::: /storage08/shuchen/parallel_dirs.txt; date;

nohup
#!/bin/zsh
OFILE=/home/gunjianpan/桌面/data/resultZ.csv
for file in Z*.csv
do
	if [ -r $file ]  #Checks if file exists and readable
	then
	  awk -F, '(NG<=4) {
	  	MAX2=-999999999;
	  	MIN2=999999999;
	  	Z=0;
	  } {
	  	if ($2 > MAX2) {
	  		MAX2 = $2
	  	}
	  	if ($2 < MIN2) {
	  		MIN2 = $2
	  	}
	  } END {
	  	Z = (sqrt(MAX2 * MAX2) >= sqrt(MIN2 * MIN2)) ? sqrt(MAX2 * MAX2) : sqrt(MIN2 * MIN2);
	  	print FILENAME","Z"\n"
	 }' $file >> $OFILE
	fi
done
cat $OFILE 
#!/bin/zsh
IFILE=/home/gunjianpan/桌面/30knot-船舯/*.csv
OFILE=/home/gunjianpan/桌面/30knot-船舯/resultR.csv
for file in /home/gunjianpan/桌面/30knot-船舯/R*.csv
do
	if [ -r $file ]  #Checks if file exists and readable
	then
	  awk -F, '(NG<=6) {
	  	MAX2=-999999999;
	  	MAX3=-999999999;
	  	MAX4=-999999999;
	  	MIN2=999999999;
	  	MIN3=999999999;
	  	MIN4=999999999;
	  	RX=0;
	  	RY=0;
	  	RZ=0;
	  } {
	  	if ($2 > MAX2) {
	  		MAX2 = $2
	  	}
	  	if ($3 > MAX3) {
	  		MAX3 = $3
	  	}
	  	if (($4 + 0) > MAX4) {
	  		MAX4 = ($4 + 0)
	  	}
	  	if ($2 < MIN2) {
	  		MIN2 = $2
	  	}
	  	if ($3 < MIN3) {
	  		MIN3 = $3
	  	}
	  	if (($4 + 0) < MIN4) {
	  		MIN4 = ($4 + 0)
	  	}
	  } END {
	  	RX = (sqrt(MAX2 * MAX2) >= sqrt(MIN2 * MIN2)) ? sqrt(MAX2 * MAX2) : sqrt(MIN2 * MIN2);
	  	RY = (sqrt(MAX3 * MAX3) >= sqrt(MIN3 * MIN3)) ? sqrt(MAX3 * MAX3) : sqrt(MIN3 * MIN3);
	  	RZ = (sqrt(MAX4 * MAX4) >= sqrt(MIN4 * MIN4)) ? sqrt(MAX4 * MAX4) : sqrt(MIN4 * MIN4);
	  	print $flie","RX","RY","RZ"\n"
	 }' $file >> $OFILE
	fi
done
cat $OFILE 
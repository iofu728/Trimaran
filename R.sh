#!/bin/zsh
OFILE=/home/gunjianpan/桌面/30knot-船舯/resultR.csv #输出文件目录
for file in R*.csv #遍历当前目录下所有文件名以R开头的.csv文件
do
	if [ -r $file ]  #检查file文件是否存在，且是否可读
	then 
	  awk -F, '(NG<=6) {  # awk是文本处理命令，-F是指输出文件时字段分隔符为空格,NG为当前已读取项目数，当NG>6时，执行后面的括号循环，
	  	MAX2=-999999999;  # 设定常量
	  	MAX3=-999999999;
	  	MAX4=-999999999;
	  	MIN2=999999999;
	  	MIN3=999999999;
	  	MIN4=999999999;
	  	RX=0;
	  	RY=0;
	  	RZ=0;
	  } {                 # 遍历
	  	if ($2 > MAX2) {
	  		MAX2 = $2     # 取最大值
	  	}
	  	if ($3 > MAX3) {
	  		MAX3 = $3
	  	}
	  	if (($4 + 0) > MAX4) {
	  		MAX4 = ($4 + 0) # +0做强制类型转换
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
	  	RX = (sqrt(MAX2 * MAX2) >= sqrt(MIN2 * MIN2)) ? sqrt(MAX2 * MAX2) : sqrt(MIN2 * MIN2); #判断取最大最小值中绝对值最大的
	  	RY = (sqrt(MAX3 * MAX3) >= sqrt(MIN3 * MIN3)) ? sqrt(MAX3 * MAX3) : sqrt(MIN3 * MIN3);
	  	RZ = (sqrt(MAX4 * MAX4) >= sqrt(MIN4 * MIN4)) ? sqrt(MAX4 * MAX4) : sqrt(MIN4 * MIN4);
	  	print FILENAME","RX","RY","RZ"\n"
	 }' $file >> $OFILE # >>为每次for循环后将结果续写入OFILE文件
	fi
done
cat $OFILE #查看OFILE文件
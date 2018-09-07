#! /bin/bash

echo -n 'insert into shareholder(rank_name,stock_code,stock_name, share_holder) values'> result2.csv
#备份IFS
OLD_IFS="$IFS"
 
#设置新的分隔符为;
IFS="!"
 
#读取文件中的行
while read LINE
 
  do
    #将字符串$LINE分割到数组
    arr=($LINE)
  
    # ${arr[@]}存储整个数组    
    for s in ${!arr[@]}  
	do
		if [[ $s = 0 ]] || [[ $s = 1 ]] ; then
            continue
        fi 
     	echo -n "('"$(($s-1))"','"${arr[0]}"','"${arr[1]}"','"${arr[$s]}"')," >>result2.csv
	done
 
  done <12.csv
 
#恢复IFS
IFS="$OLD_IFS"

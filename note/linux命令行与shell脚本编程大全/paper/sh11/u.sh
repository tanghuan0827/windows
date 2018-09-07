#!/bin/bash
>result1.csv
#stock_code=`cut -d !  -f 1 33.csv`
	for i in `seq 3 12`	
	do
		echo $i
		echo `cut -d !  -f $i 33.csv` >> result1.csv
		
	done

#!/bin/bash

outfile='members.sql'
IFS=','
#read file and create insert statements for mysql

outfile='members.sql'
IFS=','
while read lname fname address city state zip
do 
	cat >> $outfile << EOF
	INSERT INTO members (lname, fname, address, city, state, zip) values ('$lname','$fname','$address','$city', '$state','$zip');
EOF
done 

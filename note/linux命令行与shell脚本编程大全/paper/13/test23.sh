#!/bin/bash

for file in /root/*
do
	if [ -d "$file" ]
	then
		echo "$file is a directory"
	else
		echo "$file is a file"
	fi
done >output.txt

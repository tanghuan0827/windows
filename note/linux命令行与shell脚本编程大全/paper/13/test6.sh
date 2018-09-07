#!/bin/bash

for file in /root/*
do
	if [ -d "$file" ]
	then
		echo "$file is a direcotry"
	elif [ -f "$file" ]
	then
		echo "$file is a file"
	fi
done

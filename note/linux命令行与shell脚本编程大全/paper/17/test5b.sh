#!/bin/bash

function db1 {
	read -p "Enter a vlue: " value
	echo $[ $value * 2 ]
}

result=$(db1)
echo "The new value is $result"


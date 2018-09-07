#!/bin/bash
# using a function in a script

function func1 {
	echo "This is an example of a function"
}

count=1
while [ $count -le 5 ]
do
	func1
	count=$[ $count + 1 ]
done

func2
echo "Now this is the end of the script"

function func2{
	echo "This is an example of a function"
}

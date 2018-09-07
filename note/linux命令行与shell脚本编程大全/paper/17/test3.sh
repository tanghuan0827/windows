#!/bin/bash

function func1 {
	echo "This is the first definition of the function name"
}

func1

function func1 {
	echo "This is the repeat of the same function name"
}

func1
echo "This is the end of the script"


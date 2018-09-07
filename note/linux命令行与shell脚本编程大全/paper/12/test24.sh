#!/bin/bash

if [[ $USER == r* ]]
then
	echo "Hello $USER"
else
	echo "Sorry, I do not know you "
fi

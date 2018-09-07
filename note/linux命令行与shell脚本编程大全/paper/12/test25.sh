#!/bin/bash

if [ $USER = "rich" ]
then
	echo "Welcome $USER"
	echo "Please enjoy your visit"
elif [ $USER = "barbara" ]
then
	echo "Welcom $USER"
	echo "Please enjoy your visit"
elif [ $USER = "testing" ]
then
	echo "Special testing account"
elif [ $USER = "jessica" ]
then
	echo "Do not forget to logout when you're done"
else
	echo "Sorry, you are not allowed here"
fi

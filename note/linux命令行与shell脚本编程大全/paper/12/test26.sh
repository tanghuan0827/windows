#!/bin/bash

case $USER in
rich | root )
	echo "Welcome , $USER"
	echo "Please enjoy your viist";;
testing)
	echo "Special testing account";;
jessica)
	echo "Do not forget to log off when you're done";;
*)
	echo "Sorray, you are not allowed here";;
esac


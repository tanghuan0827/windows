#!/bin/bash

if [ test13.sh -nt test14.sh ]
then
	echo "The test13 file is newer than test14.sh"
else
	echo "The test14 file is newer than test19.sh"
fi

if [ test13.sh -ot test14.sh ]
then
	echo "The test13 file is older than the test14 file"
fi

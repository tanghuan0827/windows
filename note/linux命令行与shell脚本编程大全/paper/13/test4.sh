#!/bin/bash

list="Alabama Alaska Arizona Arkansas Colorado"
list=$list" Connecticut"

for state in $list
do
	echo "Have your ever visited $state?"
done

#!/bin/bash

#
# A short little script that repeats the given commands over, and over, and
# over, and over, and over, and over, until the interval runs out.

if [ $# -lt 3 ]; then
	echo Usage: repeat [iterations] [time interval] [command ... args]
	exit
fi


for ((i=3; i<$#+1; i++))
do
	s="${s} ${!i}"
done
echo $s
for ((i=0; i<$1; i++))
do
	$s
	sleep $2
done

#!/bin/bash
X=0
while [ $X -le 99 ]
do
    if [ $((X%2)) -ne 0 ] ; then
	    echo $X
    fi
	X=$((X+1))

done
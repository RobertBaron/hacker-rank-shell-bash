#!/usr/bin/env bash

read i1
read i2
read i3

if [ $i1 -eq $i2 -a $i2 -eq $i3 ] ; then
    echo "EQUILATERAL"
elif [ $i1 -eq $i2 -o $i1 -eq $i3 ] ; then
    echo "ISOSCELES"
elif [ $i2 -eq $i3 ] ; then
    echo "ISOSCELES"
else
    echo "SCALENE"
fi

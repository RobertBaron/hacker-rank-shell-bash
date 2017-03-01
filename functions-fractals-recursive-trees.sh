#!/usr/bin/env bash

rows=63
cols=100

iteration=1

declare -a grid
    # Check argument supplied
#    if [ $# -eq 0 ] then
#        draw=0
#    else
#        draw=$1
#    fi

function getIndex {
 xval=$1
 yval=$2
 local  myresult=$(( (xval*100) + yval ))
 echo "$myresult"
}

function addArt {
    iteration=1
    size=16
    while [ $iteration -le 1 ]
    do

        x=$rows
        while [ $x -gt $((rows - size)) ]
        do
           y=$((cols / (iteration + 1)))
           # x

           grid[$x,$y]="1"
           x=$((x-1))
        done

        size=$((size/2))
        iteration=$((iteration+1))
    done

}

function initGrid {
    x=$rows
    while [ $x -ge 0 ]
    do
       # y
       i=0
       y=$cols
       while [ $y -gt 0 ]
       do
           index=$(getIndex x y)
           grid[index]="_"
           y=$((y-1))
       done
       # x
       x=$((x-1))
    done

}

function printGrid {
    x=$rows
    while [ $x -ge 0 ]
    do
        # y
        y=$cols
        while [ $y -gt 0 ]
        do
            index=$(getIndex x y)
            echo -n ${grid[index]}
            y=$((y-1))
        done
        # x
        echo "$x"
        x=$((x-1))
    done
}

initGrid

#addArt
printGrid


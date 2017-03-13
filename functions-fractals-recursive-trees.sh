#!/usr/bin/env bash

_ROWS=63
_COLS=100

iterations=$1
dots=""
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

function addDots {
   for var in "$@"
    do
        grid[var]=1
    done
}

function addArt {
    size=$1
    center=$2
    startingRow=$3
    aux=$startingRow
    dotsParam=$4

    while [ $startingRow -gt $((aux - size)) ]
    do
       index=$(getIndex startingRow center)
       centerDots="$centerDots $index "
       startingRow=$((startingRow-1))
    done
    aux=$startingRow
    read right rightIndexes < <(getLegIndexes $startingRow $center $size 0)
    read left leftIndexes < <(getLegIndexes $startingRow $center $size)

    dots="$centerDots $rightIndexes $leftIndexes $dotsParam "
    subDotsR=""
    subDotsL=""
    if [ $size -gt 0 ]; then
        nextRow=$((startingRow-(size)))
        size=$((size/2))

        read subDotsR < <(addArt $size $right $nextRow $dots)
        read subDotsL < <(addArt $size $left $nextRow $dots)
    fi
    echo "$dots $subDotsR $subDotsL "
}

function getLegIndexes {
    row=$1
    col=$2
    size=$3
    direction=$4

    aux=$row
    while [ $row -gt $((aux - size)) ]
    do
       if [  -z ${direction} ] ; then
        col=$((col-1))
       else
        col=$((col+1))
       fi
       index=$(getIndex row col)
       #grid[index]=$iteration
       indexes="$indexes $index "
       row=$((row-1))
    done

    echo "$col $indexes"
}

function initGrid {
    x=$_ROWS
    while [ $x -ge 0 ]
    do
       # y
       i=0
       y=$_COLS
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
    x=$_ROWS
    x2=0
    result=[]
    while [ $x -ge 0 ]
    do
        # y
        y=$_COLS
        row=""
        while [ $y -gt 0 ]
        do
            index=$(getIndex x y)
            row="${row}${grid[index]}"
            y=$((y-1))
        done
        # x
        result[x2]=$row
        x=$((x-1))
        x2=$((x2+1))
    done

    x=$_ROWS
    while [ $x -ge 0 ]
    do
        echo ${result[x]}
        x=$((x-1))
    done
}

initGrid
read res < <(addArt 16 $((_COLS/2)) $_ROWS $dots)

addDots $res

printGrid


#!/usr/bin/env bash

_ROWS=63
_COLS=100

iterations=1
dots=""
#read N
N=5
declare -a grid

function getIndex {
 xval=$1
 yval=$2
 myresult=0
 let  myresult=xval*100+yval
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

    let whileAux=aux-size
    while [ $startingRow -gt $whileAux ]
    do
       #index=$(getIndex $startingRow $center)
       let index=startingRow*100+center
       centerDots="$centerDots $index "
       let startingRow=startingRow-1
    done
    aux=$startingRow
    read right rightIndexes < <(getLegIndexes $startingRow $center $size 0)
    read left leftIndexes < <(getLegIndexes $startingRow $center $size)

    dots="$centerDots $rightIndexes $leftIndexes $dotsParam "
    subDotsR=""
    subDotsL=""
    if [ "$iterations" -lt "$N" ]; then
        let nextRow=startingRow-size
        let size=size/2
        let iterations=iterations+1
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
    let useRows=aux-size
    while [ $row -gt $useRows ]
    do
       if [  -z ${direction} ] ; then
        let col=col-1
       else
        let col=col+1
       fi
       #index=$(getIndex $row $col)
       let index=row*100+col
       indexes="$indexes $index "
       let row=row-1
    done

    echo "$col $indexes"
}

function initGrid {
    x=$_ROWS
    while [ $x -gt 0 ]
    do
       # y
       i=0
       y=$_COLS
       while [ $y -gt 0 ]
       do
           #index=$(getIndex $x $y)
           let index=x*100+y
           grid[index]="_"

           let y=y-1
       done
       # x
       let x=x-1
    done

}

function printGrid {
    x=$_ROWS
    x2=0
    result=[]
    while [ $x -gt 0 ]
    do
        # y
        y=$_COLS
        row=""
        while [ $y -gt 0 ]
        do
            #index=$(getIndex $x $y)
            let index=x*100+y
            row="${row}${grid[index]}"
            let y=y-1
        done
        # x
        result[x2]=$row
        let x=x-1
        let x2=x2+1
    done

    let x=_ROWS-1
    while [ $x -ge 0 ]
    do
        echo ${result[x]}
        let x=x-1
    done
}

initGrid
let center=_COLS/2+1
read res < <(addArt 16 $center $_ROWS $dots)
addDots $res

printGrid


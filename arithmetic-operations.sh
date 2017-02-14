#!/usr/bin/env bash

read input
answer=$(bc -l <<< "$input")
printf "%.3f" $answer


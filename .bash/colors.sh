#!/bin/bash

# https://qiita.com/exy81/items/d58a0c6cdea46ffb36b9
# reference: man console_codes

for i in `seq 30 38` `seq 40 47` ; do
    for j in 0 1 2 4 5 7 ; do
        printf "\033[${j};${i}m"
        printf "${j};${i}"
        printf "\033[0;39;49m"  # set default
        printf " "
    done
    printf "\n"
done

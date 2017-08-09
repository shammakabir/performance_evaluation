#!/bin/bash

file=$1

grep "samples/sec" $1 | awk '{print $7}' | sed "s/Train-accuracy=//g" | awk '{sum+=$1} (NR%1000)==0{print sum/1000; sum=0}' > tmp_lr_change.txt


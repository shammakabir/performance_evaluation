#!/bin/bash
# This script just takes the samples/sec and finds the averages for a MXNET training log
# run using the command: ./parse.sh ${your_log_file}

grep samples $1 > tmp.txt
sed '51,$d' tmp.txt > tmp2.txt
#awk ' {print $5} ' tmp.txt > tmp_2.txt
awk '{ total += $5 } END { print total/NR }' tmp2.txt

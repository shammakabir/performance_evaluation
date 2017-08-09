#!/bin/bash 

network=$1
declare -a gpus=( p100 p40 k40m k80 m60 m40 )


for gpu in "${gpus[@]}"
do 
echo $gpu
output=$(/home/shamma/mxnet_test_log_480/parse.sh ${gpu}_${network}.txt)
echo $output
awk 'END{print}' tmp2.txt

done




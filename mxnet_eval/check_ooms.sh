#!/bin/bash


declare -a batch_size=( 1 2 4 6 8 16 32 64 128 256 )
declare -a gpus=( p100 p40 m60 m40 k80 k40m )
network=$1

echo this is for: $network
for batch in "${batch_size[@]}"

do

cd batch_${batch}
echo batch size:$batch

echo 
for gpu in ${gpus[@]}

do
echo gpu:$gpu
echo $( grep "out of memory" ${gpu}_${network}.txt )

done 

cd ../ 

done

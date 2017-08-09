#!/bin/bash
#changes dstat file to look at the CPU usage making it easier to plot 
#run using: ./fix_cpu ${your_network}

declare -a networks=( alexnet googlenet inception-bn inception-v3 resnet-50 resnet-152 vgg)
declare -a gpus=( p100 p40 m40 m60 k40m k80 )
declare -a batch_size=( 1 2 4 8 16 32 64 128 256 )

network=$1

cd $network


for batch in ${batch_size[@]} 
do
 cd batch_$batch
 for gpu in ${gpus[@]}
 do
 echo "hello"
 grep -e 'time' -e 'train_imagenet.py' dstat_${gpu}_${network}.csv | sed '3,${/^"system/d;}' | sed '3,${/^"time/d;}' | awk -F "\"*,\"*" '{print $290}' | grep -e 'cpu process' -e 'train_imagenet.py' > fixed_dstat_${gpu}_${network}.csv
 done
 cd ../
done 
cd ../

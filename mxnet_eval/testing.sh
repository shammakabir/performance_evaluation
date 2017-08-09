#!/bin/bash


declare -a networks=( alexnet googlenet )
declare -A gpumap=([0]=p100 [1,2]=k80 [3,4]=m60 [5]=m40 [6]=k40m [7]=p40)
declare -A timemap=([0]=1000s [1,2]=1000s [3,4]=1000s [5]=1000s [6]=1200s [7]=1000s) 
declare -a batch_size=( 1 2 4 6 8 16 32 64 128 256 )

for network in ${networks[@]}
do

cd $network
 
for batch in ${batch_size[@]}
do

mkdir batch_${batch}
cd batch_${batch}

for i in 0 1,2 3,4 5 6 7
do

timeout ${timemap[$i]} nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 10 -f ./nvidia-smi-${gpumap[$i]}_${network}.csv &
timeout ${timemap[$i]} dstat -t -c --top-cpu -md --top-bio --nvidia-gpu -f --output dstat_${gpumap[$i]}_${network}.csv &
timeout ${timemap[$i]} python /home/web/mxnet/example/image-classification/train_imagenet.py --network ${network} --gpus $i --batch-size ${batch} --num-epochs 1 --image-shape 3,480,480 --data-train /mnt/mxnet/data_resized/ilsvrc12/train.rec --data-val /mnt/mxnet/data_resized/ilsvrc12/val.rec 2>&1 | tee ${gpumap[$i]}_${network}.txt
 sleep 30

done

cd ../

done

cd ../

done

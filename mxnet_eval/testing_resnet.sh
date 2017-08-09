#!/bin/bash

network=resnet
declare -a layers=( 50 152 )
declare -A gpumap=([0]=p100 [1,2]=k80 [3,4]=m60 [5]=m40 [6]=k40m [7]=p40)
declare -a batch_size=( 1 2 4 6 8 16 32 64 128 256 )

for layer in ${layers[@]}
do

mkdir ${network}-${layer}
cd ${network}-${layer}
 
for batch in ${batch_size[@]}
do

mkdir batch_${batch}
cd batch_${batch}

for i in 0 1,2 3,4 5 6 7
do

timeout 1000 nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 10 -f ./nvidia-smi-${gpumap[$i]}_${network}-${layer}.csv &
timeout 1000 dstat -t -c --top-cpu -md --top-bio --nvidia-gpu -f --output dstat_${gpumap[$i]}_${network}-${layer}.csv &
timeout 1000 python /home/web/mxnet/example/image-classification/train_imagenet.py --network ${network} --gpus $i --num-layers ${layer} --batch-size ${batch} --num-epochs 1 --image-shape 3,480,480 --data-train /mnt/mxnet/data_resized/ilsvrc12/train.rec --data-val /mnt/mxnet/data_resized/ilsvrc12/val.rec 2>&1 | tee ${gpumap[$i]}_${network}-${layer}.txt
 sleep 30

done

cd ../

done

cd ../

done

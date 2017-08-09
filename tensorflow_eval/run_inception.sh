#!/bin/bash

declare -A declare -A gpumap=([0]=p100 [1,2]=k80 [3,4]=m60 [5]=m40 [6]=k40m [7]=p40)
declare -a batch_size=( 1 2 4 6 8 16 32 64 128 256 )

for batch in ${batch_size[@]}
do 

mkdir batch_${batch}
cd batch_${batch}

for i in 0 5 6 7
do
export CUDA_VISIBLE_DEVICES=$i
timeout 1000 nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 10 -f ./nvidia-smi-${gpumap[$i]}_inception.csv &
dstat -t -c --top-cpu -md --top-bio --nvidia-gpu -f --output dstat_${gpumap[$i]}_inception.csv 10 100 &
timeout 1000 ~/tensorflow/models/inception/bazel-bin/inception/imagenet_train --num_gpus=1 --batch_size=$batch --train_dir=/nvme/tensorflow/imagenet-data/logs --data_dir=/nvme/tensorflow/imagenet-data 2>&1 | tee ${gpumap[$i]}_inception.txt
done

for i in 1,2 3,4 
do
export CUDA_VISIBLE_DEVICES=$i
timeout 1000 nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 10 -f ./nvidia-smi-${gpumap[$i]}_inception.csv &
dstat -t -c --top-cpu -md --top-bio --nvidia-gpu -f --output dstat_${gpumap[$i]}_inception.csv 10 100 &
timeout 1000 ~/tensorflow/models/inception/bazel-bin/inception/imagenet_train --num_gpus=2 --batch_size=$batch --train_dir=/nvme/tensorflow/imagenet-data/logs --data_dir=/nvme/tensorflow/imagenet-data 2>&1 | tee ${gpumap[$i]}_inception.txt
done

done

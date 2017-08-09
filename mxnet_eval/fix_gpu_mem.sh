#!/bin/bash

# gets rid of all 0% on gpu memory usage
# run using: ./fix_gpu_mem.sh ${your_network}

declare -a gpus=( p100 p40 m40 m60 k40m k80 )
declare -a batch_size=( 1 2 4 8 16 32 64 128 256 )
network=$1


cd $network
 

for batch in ${batch_size[@]}

do
cd batch_$batch

for gpu in ${gpus[@]}
do
cp nvidia-smi-${gpu}_${network}.csv fixed_nvidia-smi-${gpu}_${network}.csv
sed -i '/^0 %/d' fixed_nvidia-smi-${gpu}_${network}.csv
done

cd ../

done

cd ..

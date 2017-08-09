#!/bin/bash

#run using ./get_batch_averages.sh ${your_network}


declare -a networks=( vgg inception-bn inception-v3 resnet-50 resnet-152 )
declare -a batch_size=( 1 2 4 6 8 16 32 64 128 256 )



network=$1

echo this is for: $network
for batch in "${batch_size[@]}"
do
cd batch_$batch

echo batch size:$batch
~/mxnet_test_log_480/get_averages.sh $network


cd ../
done

#cd ../

#done


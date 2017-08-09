#!/bin/bash


'''
Creates a CSV file with all the averages for each GPU with each batch size for inception. (TENSORFLOW)
'''



declare -a batch_size=( 1 2 4 8 16 32 64 128 256 )
declare -a gpus=( p100 p40 m60 m40 k80 k40m )

echo -n inception
for gpu in ${gpus[@]}
do
 echo -n ,${gpu}
done

echo ""

for batch in ${batch_size[@]}
do
 cd batch_$batch

 echo -n $batch

 for gpu in ${gpus[@]}
 do
  echo -n ,$(~/deeplearning_benchmarking/tensorflow_testing/tensorflow_try_2/get_avg.sh ${gpu}_inception.txt)
 done
 echo ""
 cd ../

done



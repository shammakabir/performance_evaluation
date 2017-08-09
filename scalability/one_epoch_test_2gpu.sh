#!/bin/bash


#Script to test the runtime of one epoch using MXNET on the neural networks: Resnet-50, VGG, and Inception-V3.

 

echo "Starting Resnet-50..."
(STARTTIME=$(date +%s) 
python /home/web/mxnet/example/image-classification/train_imagenet.py --network resnet --gpus 0,1 --num-layers 50 --batch-size 32 --num-epochs 1 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec 
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee resnet-50_one_epoch_2gpu_test.txt
sleep 30

echo "Starting Inception-V3..."
(STARTTIME=$(date +%s)
python /home/web/mxnet/example/image-classification/train_imagenet.py --network inception-v3 --gpus 1,2 --batch-size 64 --num-epochs 1 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec 
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee inception-v3_one_epoch_2gpu_test.txt
sleep 30

echo "Starting GoogLeNet..."
(STARTTIME=$(date +%s)
python /home/web/mxnet/example/image-classification/train_imagenet.py --network googlenet --gpus 2,3 --batch-size 128 --num-epochs 1 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec 
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee googlenet_one_epoch_2gpu_test.txt
sleep 30

echo "Starting AlexNet..."
(STARTTIME=$(date +%s)
python /home/web/mxnet/example/image-classification/train_imagenet.py --network alexnet --gpus 0,3 --batch-size 256 --num-epochs 1 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec 
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee alexnet_one_epoch_2gpu_test.txt
sleep 30

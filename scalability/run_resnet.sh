#!/bin/bash

'''
echo "Starting AlexNet..."
(STARTTIME=$(date +%s)
python /home/web/mxnet/example/image-classification/train_imagenet.py --network resnet --num-layers 50 --gpus 0,1,2,3 --batch-size 64 --num-epochs 30 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec --lr-factor .1 --lr-step-epochs 10,20
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee resnet_30_epoch_test_4GPU_LR_change.txt
sleep 30
'''

echo "Starting ResNet 30 Epochs, 2 GPU..."
(STARTTIME=$(date +%s)
python /home/web/mxnet/example/image-classification/train_imagenet.py --network resnet --num-layers 50 --gpus 0,1 --batch-size 32 --num-epochs 30 --image-shape 3,480,480 --data-train /nvme/mxnet/data/ilsvrc12/train.rec --data-val /nvme/mxnet/data/ilsvrc12/val.rec --lr-factor .1 --lr-step-epochs 10,20
ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete this task...") 2>&1 | tee resnet_30_epoch_test_2GPU_LR_change.txt
sleep 30

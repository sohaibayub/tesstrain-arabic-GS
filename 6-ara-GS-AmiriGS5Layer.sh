#!/bin/bash
# nohup bash 6-ara-GS-AmiriGS5Layer.sh > 6-ara-GS-AmiriGS5Layer.log & 

export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=AmiriGS5

nohup make  training  \
MODEL_NAME=$MODEL  \
LANG_TYPE=RTL \
BUILD_TYPE=Layer  \
TESSDATA=/home/ubuntu/tessdata_best \
GROUND_TRUTH_DIR=$SCRIPTPATH/OCR_GS_Data/ara \
START_MODEL=script/Arabic \
LAYER_NET_SPEC="[Lfx96 Lrx96 Lfx128 O1c1]" \
LAYER_APPEND_INDEX=3 \
RATIO_TRAIN=0.99 \
DEBUG_INTERVAL=-1 \
MAX_ITERATIONS=999999 > $MODEL.log & 

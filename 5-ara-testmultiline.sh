#!/bin/bash
# nohup bash 5-ara-GS-testmultiline.sh > 5-ara-GS-testmultiline.log & 
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=testmultiline
rm -rf data/$MODEL
mkdir data/$MODEL

cd data/$MODEL
wget -O $MODEL.config https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.config
wget -O $MODEL.numbers https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.numbers
wget -O $MODEL.punc https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.punc

mkdir -p  ../ara
combine_tessdata -e ~/tessdata_best/ara.traineddata $SCRIPTPATH/data/ara/$MODEL.lstm

ls -1  $SCRIPTPATH/OCR_GS_Data/ara/$MODEL/*.lstmf > /tmp/all-$MODEL-lstmf
python3 /home/ubuntu/tesstrain/shuffle.py 1 < /tmp/all-$MODEL-lstmf > all-lstmf
cat $SCRIPTPATH/OCR_GS_Data/ara/$MODEL/*.gt.txt > all-gt

cd ../..

nohup make  training  \
MODEL_NAME=$MODEL  \
LANG_TYPE=RTL \
BUILD_TYPE=Minus  \
TESSDATA=/home/ubuntu/tessdata_best \
GROUND_TRUTH_DIR=$SCRIPTPATH/OCR_GS_Data/ara \
START_MODEL=ara \
RATIO_TRAIN=0.99 \
DEBUG_INTERVAL=-1 \
MAX_ITERATIONS=400 > $MODEL.log & 

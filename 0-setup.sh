#!/bin/bash
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`

mkdir -p $SCRIPTPATH/data
mkdir -p $SCRIPTPATH/data/script/Arabic

wget -O $SCRIPTPATH/data/Latin.unicharset  https://github.com/tesseract-ocr/langdata_lstm/raw/master/Latin.unicharset
wget -O $SCRIPTPATH/data/Arabic.unicharset  https://github.com/tesseract-ocr/langdata_lstm/raw/master/Arabic.unicharset
cp /home/ubuntu/langdata_lstm/Inherited.unicharset $SCRIPTPATH/data/

wget -O $SCRIPTPATH/data/script/Arabic.traineddata https://github.com/tesseract-ocr/tessdata_best/raw/master/script/Arabic.traineddata
combine_tessdata -u $SCRIPTPATH/data/script/Arabic.traineddata $SCRIPTPATH/data/script/Arabic/Arabic.

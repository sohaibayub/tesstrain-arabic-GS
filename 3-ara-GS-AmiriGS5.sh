#!/bin/bash
# nohup bash araAmiriGS5.sh > Amiri5.log & 

export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=araAmiriGS5

rm -rf data/$MODEL
mkdir data/$MODEL

cd data/$MODEL
wget -O $MODEL.config https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.config
wget -O $MODEL.numbers https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.numbers
wget -O $MODEL.punc https://github.com/tesseract-ocr/langdata_lstm/raw/master/ara/ara.punc

mkdir -p ../ara ../script/Arabic
combine_tessdata -e ~/tessdata_best/ara.traineddata $SCRIPTPATH/data/ara/$MODEL.lstm
combine_tessdata -e ~/tessdata_best/script/Arabic.traineddata $SCRIPTPATH/data/script/Arabic/$MODEL.lstm

cat \
/home/ubuntu/tesstrain-arabic-GS/data/all-book_IbnFaqihHamadhani.Buldan-lstmf  \
/home/ubuntu/tesstrain-arabic-GS/data/all-lq_IbnJawzi.Muntazam-lstmf \
/home/ubuntu/tesstrain-arabic-GS/data/all-lq_Dhahabi.Tarikh-lstmf \
/home/ubuntu/tesstrain-arabic-GS/data/all-book_IbnAthir.Kamil-lstmf \
/home/ubuntu/tesstrain-arabic-GS/data/all-book_IbnQutayba.Adab-lstmf \
/home/ubuntu/tesstrain-arabic-GS/data/all-AmiriSynthetic-7_final_a-lstmf \
/home/ubuntu/tesstrain-arabic-GS/data/all-AmiriSynthetic-7_final_a_200-lstmf \
> all-$MODEL-lstmf

python3 /home/ubuntu/tesstrain/shuffle.py 1 < all-$MODEL-lstmf > all-lstmf

# use the normalized AWN2AEN fixed reversed text (not original .gt.txt) - .text 
echo "" > all-gt
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/lq_IbnJawzi.Muntazam/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/lq_Dhahabi.Tarikh/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnAthir.Kamil/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnQutayba.Adab/*.text; do (cat "${f}"; echo) >> all-gt; done
cat  /home/ubuntu/langdata_save_lstm/ara/ara.minusnew.training_text  >> all-gt 
sed -i -e 's/O//g' all-gt

cd ../..

nohup make  training  \
MODEL_NAME=$MODEL  \
LANG_TYPE=RTL \
BUILD_TYPE=Minus  \
TESSDATA=/home/ubuntu/tessdata_best \
GROUND_TRUTH_DIR=$SCRIPTPATH/OCR_GS_Data/ara \
START_MODEL=script/Arabic \
RATIO_TRAIN=0.99 \
DEBUG_INTERVAL=-1 \
MAX_ITERATIONS=200000 > $MODEL.log & 

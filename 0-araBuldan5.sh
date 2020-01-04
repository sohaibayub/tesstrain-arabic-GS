#!/bin/bash
# nohup bash araBuldan5.sh > buldan5.log & 

export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
MODEL=araBuldan5

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
> all-$MODEL-lstmf

python3 /home/ubuntu/tesstrain/shuffle.py 1 < all-$MODEL-lstmf > all-lstmf

# use the normalized AWN2AEN fixed reversed text (not original .gt.txt) - .text 
echo "" > all-gt
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/lq_IbnJawzi.Muntazam/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/lq_Dhahabi.Tarikh/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnAthir.Kamil/*.text; do (cat "${f}"; echo) >> all-gt; done
for f in $SCRIPTPATH/OCR_GS_Data/ara/book_IbnQutayba.Adab/*.text; do (cat "${f}"; echo) >> all-gt; done
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
###
### 
### 
### 	OMP_THREAD_LIMIT=1   time -p  lstmeval  \
### 	  --model ~/tessdata_best/script/Arabic.traineddata \
### 	  --eval_listfile /home/ubuntu/tesstrain-arabic-GS/data/araBuldan5/list.eval \
### 	  --verbosity 0
### # Encoding of string failed! 
#### At iteration 0, stage 0, Eval Char error rate=13.552394, Word error rate=30.028059
###
### 
### 	OMP_THREAD_LIMIT=1   time -p  lstmeval  \
### 	  --model ~/tessdata_best/ara.traineddata \
### 	  --eval_listfile /home/ubuntu/tesstrain-arabic-GS/data/araBuldan5/list.eval \
### 	  --verbosity 0
### # Encoding of string failed! 
#### At iteration 0, stage 0, Eval Char error rate=9.8620601, Word error rate=23.311385
###
### ##
### 	lstmtraining \
### 	--stop_training \
### 	--continue_from /home/ubuntu/tesstrain-arabic-GS/data/araBuldan5/checkpoints/araBuldan5Minus_checkpoint \
### 	--traineddata data/araBuldan5/araBuldan5.traineddata \
### 	--model_output data/araBuldan5Minus.traineddata
### 
### 	OMP_THREAD_LIMIT=1   time -p  lstmeval  \
### 	  --model  data/araBuldan5Minus.traineddata \
### 	  --eval_listfile /home/ubuntu/tesstrain-arabic-GS/data/araBuldan5/list.eval \
### 	  --verbosity 0
#### At iteration 0, stage 0, Eval Char error rate=2.2452837, Word error rate=6.501584
###
### 	OMP_THREAD_LIMIT=1   time -p  lstmeval  \
### 	  --model  data/araBuldan5Minus.traineddata \
### 	  --eval_listfile /home/ubuntu/tesstrain-arabic-GS/data/araAmiri5/list.eval \
### 	  --verbosity 0
### # Encoding of string failed! 
#### At iteration 0, stage 0, Eval Char error rate=4.6704705, Word error rate=11.912448
### 
###
### 
 
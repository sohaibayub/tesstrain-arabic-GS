#!/bin/sh
# nohup bash 9-run_tess_tests.sh AmiriGS5 Minus > reports/AmiriGS5Minus_fast-reports.txt & 
# nohup bash 9-run_tess_tests.sh AmiriGS5 Layer > reports/AmiriGS5Layer_fast-reports.txt & 
# 
SCRIPTPATH=`pwd`
LANG=$1
BUILDTYPE=$2
CHECKPOINT=${LANG}${BUILDTYPE}
MODEL=${CHECKPOINT}_fast

 	lstmtraining \
 	--stop_training \
 	--continue_from $SCRIPTPATH/data/$LANG/checkpoints/${CHECKPOINT}_checkpoint \
 	--traineddata data/$LANG/$LANG.traineddata \
 	--model_output data/${CHECKPOINT}.traineddata

 	lstmtraining \
 	--stop_training \
    --convert_to_int \
 	--continue_from $SCRIPTPATH/data/$LANG/checkpoints/${CHECKPOINT}_checkpoint \
 	--traineddata data/$LANG/$LANG.traineddata \
 	--model_output data/$MODEL.traineddata

cd  $SCRIPTPATH/OCR_GS_Data/ara
for BOOK in book_Yacqubi.Tarikh  book_Jahiz.Hayawan  book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  ; do
    cd $BOOK
    REPORTSPATH=../$BOOK-reports-$MODEL
    rm -rf $REPORTSPATH
    mkdir $REPORTSPATH
    for VAR in "_a" "_b" "_a_200" "_b_200" ;    do
        FOLDER="7_final"$VAR
        pwd
        echo "$BOOK"-"$FOLDER" 
        echo "$BOOK"-"$FOLDER" > ../$BOOK-$FOLDER-manifest.log
        my_files=$(ls $FOLDER-*.png)
        for my_file in ${my_files}; do
            echo "$BOOK"-"$my_file" >> ../$BOOK-$FOLDER-manifest.log
            OMP_THREAD_LIMIT=1 tesseract $my_file  "${my_file%.*}-$MODEL" --oem 1 --psm 13  -l "$MODEL" --tessdata-dir $SCRIPTPATH/data  -c page_separator=''   1>/dev/null 2>&1
        done
        for f in $FOLDER-*.gt.txt ; do (cat "${f}"; echo) >> "$REPORTSPATH/g$VAR.txt" ; done
        cat $FOLDER-*-$MODEL.txt   >  "$REPORTSPATH/$MODEL$VAR.txt"
        ocrevalutf8 accuracy "$REPORTSPATH/g$VAR.txt"  "$REPORTSPATH/$MODEL$VAR.txt"  > "$REPORTSPATH/report_$MODEL$VAR.txt"
        head -26 "$REPORTSPATH/report_$MODEL$VAR.txt"
    done
    cd ..
done

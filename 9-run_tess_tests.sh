#!/bin/sh
# nohup bash 9-run_tess_tests.sh araAmiri5 > araAmiri5Minus_fast-reports.txt & 
# nohup bash 9-run_tess_tests.sh araAmiriGS5 > araAmiriGS5Minus_fast-reports.txt & 

SCRIPTPATH=`pwd`
MODEL=$1
MINUSMODEL=${MODEL}Minus_fast

 	lstmtraining \
 	--stop_training \
 	--continue_from $SCRIPTPATH/data/$MODEL/checkpoints/${MODEL}Minus_checkpoint \
 	--traineddata data/$MODEL/$MODEL.traineddata \
 	--model_output data/${MODEL}Minus.traineddata

 	lstmtraining \
 	--stop_training \
    --convert_to_int \
 	--continue_from $SCRIPTPATH/data/$MODEL/checkpoints/${MODEL}Minus_checkpoint \
 	--traineddata data/$MODEL/$MODEL.traineddata \
 	--model_output data/$MINUSMODEL.traineddata

cd  $SCRIPTPATH/OCR_GS_Data/ara
for BOOK in  book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
    cd $BOOK
    REPORTSPATH=../$BOOK-reports-$MINUSMODEL
    rm -rf $REPORTSPATH
    mkdir $REPORTSPATH
    for VAR in "_a" "_b" "_a_200" "_b_200" ;    do
        FOLDER="7_final"$VAR
        pwd
        echo "$FOLDER"
        ls $FOLDER-*.png > $FOLDER-manifest.log
        my_files=$(ls $FOLDER-*.png)
        for my_file in ${my_files}; do
            OMP_THREAD_LIMIT=1 tesseract $my_file  "${my_file%.*}-$MINUSMODEL" --oem 1 --psm 13  -l "$MINUSMODEL" --tessdata-dir $SCRIPTPATH/data  -c page_separator=''   1>/dev/null 2>&1
        done
        for f in $FOLDER-*.text ; do (cat "${f}"; echo) >> "$REPORTSPATH/g$VAR.txt" ; done
        cat $FOLDER-*-$MINUSMODEL.txt   >  "$REPORTSPATH/$MINUSMODEL$VAR.txt"
        ocrevalutf8 accuracy "$REPORTSPATH/g$VAR.txt"  "$REPORTSPATH/$MINUSMODEL$VAR.txt"  > "$REPORTSPATH/report_$MINUSMODEL$VAR.txt"
        head -26 "$REPORTSPATH/report_$MINUSMODEL$VAR.txt"
    done
    cd ..
done

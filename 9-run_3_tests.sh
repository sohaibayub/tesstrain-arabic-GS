#!/bin/sh
# nohup bash 9-run_3_tests.sh AmiriGS5 Layer > reports/AmiriGS5Layer_fast-3_reports.txt & 
# 
SCRIPTPATH=`pwd`
LANG=$1
BUILDTYPE=$2
CHECKPOINT=${LANG}${BUILDTYPE}
MODEL=${CHECKPOINT}_fast

rm data/$LANG/tessdata_fast/*.traineddata
ls -t data/$LANG/checkpoints/*.checkpoint | head -3 > tmpcheckpoints
CHECKPOINT_FILES=tmpcheckpoints
while IFS= read -r TESTCHECK
do
    make traineddata MODEL_NAME=AmiriGS5  LANG_TYPE=RTL BUILD_TYPE=Layer  CHECKPOINT_FILES=$TESTCHECK
done < "$CHECKPOINT_FILES"

TRAINEDDATAFILES=data/$LANG/tessdata_fast/*.traineddata
for TRAINEDDATA in $TRAINEDDATAFILES  ; do
     TRAINEDDATAFILE="$(basename -- $TRAINEDDATA)"
      echo -e  "\n*****************************************************************************************\n"
        cd  $SCRIPTPATH/OCR_GS_Data/ara

        for BOOK in book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
            cd $BOOK
            REPORTSPATH=../$BOOK-${TRAINEDDATAFILE%.*}
            rm -rf $REPORTSPATH
            mkdir $REPORTSPATH

            for VAR in "_a"  "_a_200" ;    do
                FOLDER="7_final"$VAR
                echo -e  "\n-----------------------------------------------------------------------------"  "$BOOK"-"$FOLDER"-${TRAINEDDATAFILE%.*}   
                my_files=$(ls $FOLDER-*.png)

                for my_file in ${my_files}; do
                        OMP_THREAD_LIMIT=1 tesseract $my_file  "${my_file%.*}-${TRAINEDDATAFILE%.*}" --oem 1 --psm 13  -l  ${TRAINEDDATAFILE%.*}  --tessdata-dir $SCRIPTPATH/data/$LANG/tessdata_fast/  -c page_separator=''     1>/dev/null 2>&1
                        cat "${my_file%.*}".gt.txt   >>   "$REPORTSPATH/gt-$FOLDER.txt" 
                        cat "${my_file%.*}-${TRAINEDDATAFILE%.*}".txt   >>  "$REPORTSPATH/${TRAINEDDATAFILE%.*}-$FOLDER.txt"
                done

                ocrevalutf8 accuracy "$REPORTSPATH/gt-$FOLDER.txt"  "$REPORTSPATH/${TRAINEDDATAFILE%.*}-$FOLDER.txt"  > "$REPORTSPATH/report_${TRAINEDDATAFILE%.*}-$FOLDER.txt"
                head -26 "$REPORTSPATH/report_${TRAINEDDATAFILE%.*}-$FOLDER.txt"
            done

            cd ..
        done

done
rm tmpcheckpoints


#!/bin/sh
# nohup bash 9-run_fast_ara_tests.sh > fast_ara-reports.txt & 

SCRIPTPATH=`pwd`
FASTMODEL=fast_ara
cp ~/tessdata_fast/ara.traineddata $SCRIPTPATH/data/fast_ara.traineddata

cd  $SCRIPTPATH/OCR_GS_Data/ara
for BOOK in book_Yacqubi.Tarikh  book_Jahiz.Hayawan  book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  ; do
    cd $BOOK
    REPORTSPATH=../$BOOK-reports-$FASTMODEL
    rm -rf $REPORTSPATH
    mkdir $REPORTSPATH
    for VAR in "_a" "_b" "_a_200" "_b_200" ;    do
        FOLDER="7_final"$VAR
        pwd
        echo "$BOOK"-"$FOLDER" > ../$BOOK-$FOLDER-manifest.log
        my_files=$(ls $FOLDER-*.png)
        for my_file in ${my_files}; do
            echo "$BOOK"-"$my_file" >> ../$BOOK-$FOLDER-manifest.log
            OMP_THREAD_LIMIT=1 tesseract $my_file  "${my_file%.*}-$FASTMODEL" --oem 1 --psm 13  -l "$FASTMODEL" --tessdata-dir $SCRIPTPATH/data  -c page_separator=''   1>/dev/null 2>&1
        done
        for f in $FOLDER-*.gt.txt ; do (cat "${f}"; echo) >> "$REPORTSPATH/g$VAR.txt" ; done
        cat $FOLDER-*-$FASTMODEL.txt   >  "$REPORTSPATH/$FASTMODEL$VAR.txt"
        ocrevalutf8 accuracy "$REPORTSPATH/g$VAR.txt"  "$REPORTSPATH/$FASTMODEL$VAR.txt"  > "$REPORTSPATH/report_$FASTMODEL$VAR.txt"
        head -26 "$REPORTSPATH/report_$FASTMODEL$VAR.txt"
    done
    cd ..
done

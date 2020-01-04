#!/bin/bash
# nohup bash 3-ara-GS-fix.sh > lstmf.log & 
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`

cd  $SCRIPTPATH/OCR_GS_Data/ara
for book in  book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
    cd $book
    rm  *.box *.lstmf
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
        sed -i -f $SCRIPTPATH/AWN2AEN.sed "${my_file%.*}".gt.txt 
        python3 $SCRIPTPATH/normalize.py -v "${my_file%.*}".gt.txt 
    done
    echo "Done with $book"
    cd ..
done
echo "All Done"

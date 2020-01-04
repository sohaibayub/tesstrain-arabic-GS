#!/bin/bash
# nohup bash ara-GS-gt2lstmf.sh > lstmf.log & 

export PYTHONIOENCODING=utf8
ulimit -s 65536

SCRIPTPATH=`pwd`

cd  $SCRIPTPATH/OCR_GS_Data/ara
for book in  book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
    cd $book
    rm  *.text *.box *.lstmf
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
        sed -i -f $SCRIPTPATH/AWN2AEN.sed "${my_file%.*}".gt.txt 
        python3 $SCRIPTPATH/normalize.py -v "${my_file%.*}".gt.txt 
        python3 $SCRIPTPATH/generate_wordstr_box.py -t "${my_file%.*}".gt.txt  -i  "${my_file}" --rtl > "${my_file%.*}".box
        OMP_THREAD_LIMIT=1  tesseract "${my_file}" "${my_file%.*}" -l ara --psm 13 --dpi 300 lstm.train  
    done
    ls -1  $SCRIPTPATH/OCR_GS_Data/ara/$book/*.lstmf > $SCRIPTPATH/data/all-$book-lstmf
    echo "Done with $book"
    cd ..
done
echo "All Done"

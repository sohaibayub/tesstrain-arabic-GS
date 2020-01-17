#!/bin/bash
# nohup bash Amiri-gt2lstmf.sh > lstmf.log & 

export PYTHONIOENCODING=utf8
ulimit -s 65536

SCRIPTPATH=`pwd`

cd  $SCRIPTPATH/OCR_GS_Data/ara/AmiriSynthetic
for book in 7_final_a 7_final_a_200  ; do
    cd $book
    my_files=$(ls *.tif)
    for my_file in ${my_files}; do
        python3 $SCRIPTPATH/generate_wordstr_box.py -t "${my_file%.*}".gt.txt  -i  "${my_file}" --rtl > "${my_file%.*}".box
        OMP_THREAD_LIMIT=1  tesseract "${my_file}" "${my_file%.*}" -l ara --psm 13 --dpi 300 lstm.train  1>/dev/null 2>&1
    done
    ls -1  $SCRIPTPATH/OCR_GS_Data/ara/AmiriSynthetic/$book/*.lstmf > $SCRIPTPATH/data/all-AmiriSynthetic-$book-lstmf
    echo "Done with $book"
    cd ..
done
echo "All Done"

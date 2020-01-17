#!/bin/bash
# use --psm 4 for multi-line images, --psm 13 for single line
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`

cd  $SCRIPTPATH/OCR_GS_Data/ara
for book in testsingleline ; do
    cd $book
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
       echo "${my_file}"
       OMP_THREAD_LIMIT=1  time -p tesseract "${my_file}" "${my_file%.*}-AmiriGS5Minus_fast" -l AmiriGS5Minus_fast --tessdata-dir $SCRIPTPATH/data --psm 13 --dpi 300  -c page_separator=''   
       OMP_THREAD_LIMIT=1  time -p tesseract "${my_file}" "${my_file%.*}-AmiriGS5Layer_fast" -l AmiriGS5Layer_fast --tessdata-dir $SCRIPTPATH/data --psm 13 --dpi 300  -c page_separator=''  
    done
    echo "Done with $book"
    cd ..
done

for book in testmultiline ; do
    cd $book
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
       echo "${my_file}"
       OMP_THREAD_LIMIT=1  time -p tesseract "${my_file}" "${my_file%.*}-AmiriGS5Minus_fast" -l AmiriGS5Minus_fast --tessdata-dir $SCRIPTPATH/data --psm 4 --dpi 300  -c page_separator=''   
       OMP_THREAD_LIMIT=1  time -p tesseract "${my_file}" "${my_file%.*}-AmiriGS5Layer_fast" -l AmiriGS5Layer_fast --tessdata-dir $SCRIPTPATH/data --psm 4 --dpi 300  -c page_separator=''  
    done
    echo "Done with $book"
    cd ..
done

echo "All Done"


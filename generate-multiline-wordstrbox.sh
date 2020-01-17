#!/bin/bash
# use --psm 4 for multi-line images
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
cd  $SCRIPTPATH/OCR_GS_Data/ara
for book in testmultiline ; do
    cd $book
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
        echo -e "\n${my_file%.*}"
        python3 $SCRIPTPATH/generate_bidi.py -t ${my_file%.*}.gt.txt > ${my_file%.*}.bidi.txt
        OMP_THREAD_LIMIT=1 tesseract $my_file        ${my_file%.*} -l ara --psm 4 wordstrbox
        mv "${my_file%.*}.box" "${my_file%.*}.wordstrbox" 
        sed -i -e "s/ \#.*/ \#/g"  ${my_file%.*}.wordstrbox
        sed -e '/^$/d' ${my_file%.*}.bidi.txt > ${my_file%.*}.tmp
        sed -e  's/$/\n/g'  ${my_file%.*}.tmp > ${my_file%.*}.bidi.txt
        paste --delimiters="\0"  ${my_file%.*}.wordstrbox  ${my_file%.*}.bidi.txt > ${my_file%.*}.box
        OMP_THREAD_LIMIT=1 tesseract $my_file ${my_file%.*} -l san --psm 4 lstm.train

        # rm ${my_file%.*}.wordstrbox  ${my_file%.*}.tmp ${my_file%.*}.bidi.txt
    done
    echo "Done with $book"
    cd ..
done
echo "All Done"

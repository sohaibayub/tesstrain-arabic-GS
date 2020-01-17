#!/bin/bash
export PYTHONIOENCODING=utf8
ulimit -s 65536
SCRIPTPATH=`pwd`
fontname="Amiri"
fontsdir="~/.fonts"

cd  $SCRIPTPATH/OCR_GS_Data/ara
for book in testsingleline ; do
    cd $book
    rm  *.box.txt *.tif *.box *.lstmf 
    my_files=$(ls *.png)
    for my_file in ${my_files}; do
# text2image method - do not use
# make .tif and reveresed charbox .box from .txt
        OMP_THREAD_LIMIT=1  text2image --strip_unrenderable_words=false --fonts_dir=$fontsdir --font=$fontname --text="${my_file%.*}".gt.txt --outputbase="${my_file%.*}" 
# make reversed gt from charbox
        python3 $SCRIPTPATH/generate_gt_from_charbox.py  -b  "${my_file%.*}".box   -t "${my_file%.*}".box.txt 
# make wordstrbox from generated reversed gt from charbox and original image
        python3 $SCRIPTPATH/generate_wordstr_box.py -t "${my_file%.*}".box.txt  -i  "${my_file}" > "${my_file%.*}".wordstr.box

# new pythonic method using bidi
        python3 $SCRIPTPATH/generate_wordstr_box.py -t "${my_file%.*}".gt.txt  -i  "${my_file}" --rtl > "${my_file%.*}".bidi.box 
# bidi.box is correct for parenthesis etc.
        diff "${my_file%.*}".wordstr.box  "${my_file%.*}".bidi.box 
    done
    echo "Done with $book"
    cd ..
done
echo "All Done"

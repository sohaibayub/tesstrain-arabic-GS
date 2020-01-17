#!/bin/bash
# single line images using text2image

### change these 2 parameters as needed ###
unicodefontdir=/home/ubuntu/.fonts
prefix=7_final_a_200
####

rm -rf ./OCR_GS_Data/ara/AmiriSynthetic/${prefix}  
mkdir  ./OCR_GS_Data/ara/AmiriSynthetic
mkdir  ./OCR_GS_Data/ara/AmiriSynthetic/${prefix}  

# input files 
traininginput=/tmp/${prefix}-input.txt
fontlist=/tmp/${prefix}-unicode-fonts.txt
# files created by script during processing
trainingtext=/tmp/tmp${prefix}-train.txt
filetext=/tmp/tmp${prefix}-file-train.txt

### change following two source file names as needed ###
python3 ~/tesstrain/normalize.py -v /home/ubuntu/langdata_save_lstm/ara/ara.minusnew.training_text 
cp  /home/ubuntu/langdata_save_lstm/ara/ara.minusnew.training_text   ${traininginput}
echo "Amiri" >   ${fontlist}
###

linecount=$(wc -l < "$traininginput")
numlines=1
numfiles=$((linecount / numlines))


while IFS= read -r fontname
    do
       cp ${traininginput}  ${trainingtext}
       for cnt in $(seq 1 $numfiles) ; do
            head -$numlines ${trainingtext} > ${filetext}
            sed -i  "1,$numlines  d"  ${trainingtext}
            imagebase="./OCR_GS_Data/ara/AmiriSynthetic/${prefix}/${fontname// /_}_200-$cnt"
            OMP_THREAD_LIMIT=1    text2image --fonts_dir="$unicodefontdir"  --strip_unrenderable_words=false --xsize=3000 --ysize=150  --leading=32 --margin=12 --exposure=0  --font="$fontname" --text="$filetext"  --outputbase="$imagebase"  --resolution=200
            cp "$filetext" "$imagebase".gt.txt
            rm "$imagebase".box
       done
    done < "$fontlist"

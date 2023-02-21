# tesstrain-arabic-GS

Finetune Training and OCR evaluation of Tesseract 5.0.0 Alpha for Arabic using
[Double-checked Gold Standard Data for Arabic for Training and Testing OCR Engines](https://github.com/OpenArabic/OCR_GS_Data)
and [tesstrain Training workflow for Tesseract 4 as a Makefile](https://github.com/tesseract-ocr/tesstrain).

Certain file locations and scripts have been modified compared to source repos.

## Tesseract 5.0.0Alpha - araAmiriGS5 models

Wordstr format .box and .lstmf files were created using bash scripts outside of `tesstrain` makefile process.

* [AmiriGS5.unicharset](https://github.com/baajur/tesstrain-arabic-GS/blob/master/data/AmiriGS5/AmiriGS5.unicharset) (122 characters)
* [AmiriGS5Layer_fast.traineddata](https://github.com/baajur/tesstrain-arabic-GS/blob/master/data/AmiriGS5Layer_fast.traineddata)
* [AmiriGS5Minus_fast.traineddata](https://github.com/baajur/tesstrain-arabic-GS/blob/master/data/AmiriGS5Minus_fast.traineddata)

### Input Files used for Tesseract finetune training from tessdata_best/script/Arabic.traineddata

#### OpenArabic/OCR_GS_Data - Scanned images and trascription from 5 books

* [OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan](OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan)
* [OCR_GS_Data/ara/lq_IbnJawzi.Muntazam](OCR_GS_Data/ara/lq_IbnJawzi.Muntazam)
* [OCR_GS_Data/ara/lq_Dhahabi.Tarikh](OCR_GS_Data/ara/lq_Dhahabi.Tarikh)
* [OCR_GS_Data/ara/book_IbnQutayba.Adab](OCR_GS_Data/ara/book_IbnQutayba.Adab)
* [OCR_GS_Data/ara/book_IbnAthir.Kamil](OCR_GS_Data/ara/book_IbnAthir.Kamil)

#### Synthetic training data

Synthetic training data in Amiri font was also used to generalize the model,
with images at 300 and 200 dpi generated using `text2image`.

* [OCR_GS_Data/ara/AmiriSynthetic](OCR_GS_Data/ara/AmiriSynthetic)

#### araAmiriGS5 OCR evaluation reports  (Integer version trained till 0.887% CER - 200000 iterations)

Evaluation was done on 2 scanned books in addition to the 5 used for training.

* [Evaluation reports summary](https://github.com/baajur/tesstrain-arabic-GS/tree/master/reports)
* [Detailed evaluation reports per book](https://github.com/baajur/tesstrain-arabic-GS/tree/master/OCR_GS_Data/ara)


## OpenArabic/Kraken

### OpenArabic/OCR_GS_Data and OCR evaluation reports

* [book_IbnFaqihHamadhani.Buldan](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnFaqihHamadhani.Buldan)
* [lq_IbnJawzi.Muntazam](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/lq_IbnJawzi.Muntazam)
* [lq_Dhahabi.Tarikh](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/lq_Dhahabi.Tarikh)
* [book_IbnQutayba.Adab](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnQutayba.Adab)
* [book_IbnAthir.Kamil](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnAthir.Kamil)
* [book_Yacqubi.Tarikh](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_Yacqubi.Tarikh)
* [book_Jahiz.Hayawan](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_Jahiz.Hayawan)

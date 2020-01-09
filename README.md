# tesstrain-arabic-GS

Finetune Training and OCR evaluation of Tesseract 5.0.0 Alpha for Arabic using
[Double-checked Gold Standard Data for Arabic for Training and Testing OCR Engines](https://github.com/OpenArabic/OCR_GS_Data)
and [tesstrain Training workflow for Tesseract 4 as a Makefile](https://github.com/tesseract-ocr/tesstrain).

Certain file locations and scripts have been modified compared to source repos.

## Tesseract 5.0.0Alpha - araAmiriGS5Minus model

Wordstr format .box and .lstmf files were created using bash scripts outside of makefile process.

* [data/araAmiriGS5/araAmiriGS5.unicharset](data/araAmiriGS5/araAmiriGS5.unicharset) (121 characters)
* [data/araAmiriGS5Minus.traineddata](data/araAmiriGS5Minus.traineddata)
* [data/araAmiriGS5Minus_fast.traineddata](data/araAmiriGS5Minus_fast.traineddata) (fast Integer model)

### Input Files used for Tesseract finetune training from tessdata_best/script/Arabic.traineddata

#### OpenArabic/OCR_GS_Data - Scanned images and trascription

* [OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan](OCR_GS_Data/ara/book_IbnFaqihHamadhani.Buldan)
* [OCR_GS_Data/ara/lq_IbnJawzi.Muntazam](OCR_GS_Data/ara/lq_IbnJawzi.Muntazam)
* [OCR_GS_Data/ara/lq_Dhahabi.Tarikh](OCR_GS_Data/ara/lq_Dhahabi.Tarikh)
* [OCR_GS_Data/ara/book_IbnQutayba.Adab](OCR_GS_Data/ara/book_IbnQutayba.Adab)
* [OCR_GS_Data/ara/book_IbnAthir.Kamil](OCR_GS_Data/ara/book_IbnAthir.Kamil)

#### Synthetic training data

Synthetic training data in Amiri font was also used to generalize the model,
with images at 300 and 200 dpi generated using `text2image`.

* [OCR_GS_Data/ara/AmiriSynthetic/7_final_a](OCR_GS_Data/ara/AmiriSynthetic/7_final_a)
* [OCR_GS_Data/ara/AmiriSynthetic/7_final_a_200](OCR_GS_Data/ara/AmiriSynthetic/7_final_a_200)

#### araAmiriGS5Minus OCR evaluation reports  (Integer version trained till ~1%  CER)

###### on books different from training data

* [OCR_GS_Data/ara/book_Yacqubi.Tarikh-reports-araAmiriGS5Minus_fast](OCR_GS_Data/ara/book_Yacqubi.Tarikh-reports-araAmiriGS5Minus_fast)
* [OCR_GS_Data/ara/book_Jahiz.Hayawan-reports-araAmiriGS5Minus_fast](OCR_GS_Data/ara/book_Jahiz.Hayawan-reports-araAmiriGS5Minus_fast)

## OpenArabic/Kraken

### OpenArabic/OCR_GS_Data and OCR evaluation reports

* [book_IbnFaqihHamadhani.Buldan](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnFaqihHamadhani.Buldan)
* [lq_IbnJawzi.Muntazam](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/lq_IbnJawzi.Muntazam
* [lq_Dhahabi.Tarikh](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/lq_Dhahabi.Tarikh)
* [book_IbnQutayba.Adab](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnQutayba.Adab)
* [book_IbnAthir.Kamil](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_IbnAthir.Kamil)
* [book_Yacqubi.Tarikh](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_Yacqubi.Tarikh)
* [book_Jahiz.Hayawan](https://github.com/OpenArabic/OCR_GS_Data/tree/master/ara/book_Jahiz.Hayawan)

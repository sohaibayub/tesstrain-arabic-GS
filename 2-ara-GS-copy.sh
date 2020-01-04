
cd  ~/OCR_GS_Data/ara
for book in book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
rm -rf ~/tesstrain-arabic-GS/OCR_GS_Data/ara/$book
mkdir ~/tesstrain-arabic-GS/OCR_GS_Data/ara/$book
cd $book 
	 find ./ -type f -name "7_*.gt.txt" -exec cp -f  {} ~/tesstrain-arabic-GS/OCR_GS_Data/ara/$book/ \;
	 find ./ -type f -name "7_*.png" -exec cp -f  {} ~/tesstrain-arabic-GS/OCR_GS_Data/ara/$book/ \;
cd ..
done
cd ../..
 
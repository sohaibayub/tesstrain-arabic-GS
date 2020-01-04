cd  ~/OCR_GS_Data/ara
for book in book_IbnFaqihHamadhani.Buldan  lq_IbnJawzi.Muntazam   lq_Dhahabi.Tarikh  book_IbnQutayba.Adab  book_IbnAthir.Kamil  book_Yacqubi.Tarikh  book_Jahiz.Hayawan ; do
cd $book 
	 find 7_final_a -name "*.gt.txt" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_a -name "*.png" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_a_200 -name "*.gt.txt" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_a_200 -name "*.png" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_b -name "*.gt.txt" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_b -name "*.png" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_b_200 -name "*.gt.txt" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
	 find 7_final_b_200 -name "*.png" | sed 'h;y/\//-/;H;g;s/\n/ /g;s/^/cp  -v /' | sh
cd ..
done
 
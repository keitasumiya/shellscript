#!/bin/sh
cd file/

cp *.pdf ../pdf/

cd ../pdf/
ls | sed 's/\./_/g' | awk -F'_| ' '{print "echo",$1"_"$2,">",$1".txt"}' | sh
ls | grep .txt | awk '{print "mv",$0,"../txt"}' | sh

cd ../txt
ls | sed 's/\./_/g' | awk -F'_| ' '{print "pandoc",$1".txt -o",$1".pdf -V documentclass=ltjarticle --latex-engine=lualatex -V geometry:margin=0mm -V papersize:a4"}' | sh
ls | grep .pdf | awk '{print "mv",$0,"../txt_pdf"}' | sh

cd ../pdf
ls | awk -F'_| ' '{print "pdftk",$0,"stamp ../txt_pdf/"$1".pdf","output ../output_pdf/"$1".pdf"}' | sh

cd ../output_pdf
pdftk *.pdf output ../output.pdf
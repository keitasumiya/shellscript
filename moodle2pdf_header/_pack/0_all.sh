#!/bin/sh

mkdir pdf
mkdir txt
mkdir txt_pdf
mkdir output_pdf

cd students/
sed -e '1d' *.csv > students.txt
cat students.txt | awk -F',| ' '{print $2"_"$1"_"substr($6,2,6)}' > students_edited.txt

cd ../file/
ls | awk '{a=$0; gsub(" ","_",a); print "mv \""$0"\" \""a"\""}' | sh
ls | sed 's/\./zzzz/g' | awk -F'_|zzzz| ' '{a=$0; gsub("zzzz",".",a); print "mv \""a"\" \""$1"_"$2"."$NF"\""}' | sh
for i in `ls`; do echo $i" "`grep ${i%.*} ../students/students_edited.txt` | sed 's/\./ /g' |awk -F' |_' '{print "mv "$1"_"$2"."$3" "$6"_"$1$2"."$3}' | sh; done

for i in `ls | grep -v .pdf`; do soffice --headless --convert-to pdf:writer_pdf_Export $i; done

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
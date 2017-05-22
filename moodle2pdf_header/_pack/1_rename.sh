#!/bin/sh

mkdir pdf
mkdir txt
mkdir txt_pdf
mkdir output_pdf

cd students/
sed -e '1d' *.csv > students.txt
cat students.txt | awk -F',| ' '{print $2"_"$1"_"substr($6,2,6)}' > students_edited.txt

cd ../file/
ls | awk '{a=$0; gsub(" ","_",a); print "mv \""$0"\"",a}' | sh
ls | sed 's/\./zzzz/g' | awk -F'_|zzzz| ' '{a=$0; gsub("zzzz",".",a); print "mv",a,$1"_"$2"."$NF}' | sh
for i in `ls`; do echo $i" "`grep ${i%.*} ../students/students_edited.txt` | sed 's/\./ /g' |awk -F' |_' '{print "mv "$1"_"$2"."$3" "$6"_"$1$2"."$3}' | sh; done

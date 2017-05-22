# environments

```
mac osx 10.11 el capitan
pandoc 1.17.0.3 < Compiled with texmath 0.8.6.3, highlighting-kate 0.6.2.
pdftk2.02
```

# explanation

```
new article
http://qiita.com/keitasumiya/items/665453b54a9ffb4cfdaf

old article
http://qiita.com/keitasumiya/items/7975b068f22ddb7ddb82
```

# tree

```
$ tree
.
├── file
│   ├── Sato\ Jiro_123102_assignsubmission_file_課?\214.pdf
│   ├── Yamada\ Taro_123001_assignsubmission_file_abc?\217?\201?課?\214.docx
│   └── 山?\234?\ ?\211?\203\216_123023_assignsubmission_onlinetext_onlinetext.html
└── students
    └── 987654_2017\ ?\225?\232-20170510_0831-comma_separated.csv
```

# commands

```
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
```

make each file to pdf by acrobat

```
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
```



# bash

```tree.
$ tree
.
├── 1_rename.sh
├── 2_mk_merge_pdf.sh
├── file
│   ├── Sato\ Jiro_123102_assignsubmission_file_課?\214.pdf
│   ├── Yamada\ Taro_123001_assignsubmission_file_abc?\217?\201?課?\214.docx
│   └── 山?\234?\ ?\211?\203\216_123023_assignsubmission_onlinetext_onlinetext.html
└── students
    └── 987654_2017\ ?\225?\232-20170510_0831-comma_separated.csv
```

```1_rename.sh
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
```

```2_mk_merge_pdf.sh
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
```

## usage
```usage 1.
chmod +x 1_rename.sh
chmod +x 2_mk_merge_pdf.sh 
./1_rename.sh
```
pdf化 by acrobat

```usage 2.
./2_mk_merge_pdf.sh 
```

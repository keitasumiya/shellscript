# environments

```
mac osx 10.11 el capitan
pandoc 1.17.0.3 < Compiled with texmath 0.8.6.3, highlighting-kate 0.6.2.
pdftk2.02
```

# explanation
http://qiita.com/keitasumiya/items/8f4febe8d5a0b66a4b9a

# tree

```
$ tree
.
└── pdf
    ├── ab9999_YamadaTaro.pdf
    ├── ef9990_山本三郎.pdf
    └── hg9980_SatoJiro.pdf
```

# commands

```
mkdir txt
mkdir txt_pdf
mkdir output_pdf

cd pdf
ls | sed 's/\./_/g' | awk -F'_| ' '{print "echo",$1"_"$2,">",$1".txt"}' | sh
ls | grep .txt | awk '{print "mv",$0,"../txt"}' | sh

cd ../txt
ls | sed 's/\./_/g' | awk -F'_| ' '{print "pandoc",$1".txt -o",$1".pdf -V documentclass=ltjarticle --latex-engine=lualatex -V geometry:margin=0mm -V fontsize=12pt -V papersize:a4"}' | sh
ls | grep .pdf | awk '{print "mv",$0,"../txt_pdf"}' | sh

cd ../pdf
ls | awk -F'_| ' '{print "pdftk",$0,"stamp ../txt_pdf/"$1".pdf","output ../output_pdf/"$1".pdf"}' | sh

cd ../output_pdf
pdftk *.pdf output ../output.pdf
```
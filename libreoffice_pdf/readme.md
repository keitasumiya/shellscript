# environment
mac osx 10.11 el capitan
LibreOffice 5.3.3.2

# preparation
## install
https://www.libreoffice.org/get-help/install-howto/os-x/

# set path

```
1. open
emacs ~/.bashr

2. add followings:
#libreoffice
export PATH=$PATH:/Applications/LibreOffice.app/Contents/MacOS

3. re-open terminal
```

# usage

```
doc2pdf(before set path):
/Applications/LibreOffice.app/Contents/MacOS/soffice --headless --convert-to pdf:writer_pdf_Export *.doc

doc2pdf(after set path):
soffice --headless --convert-to pdf:writer_pdf_Export *.doc

version_check:
soffice --version

help:
soffice --help
```

# result
"to pdf" test. 
### good
doc
html
ppt
pptx
rtf
txt
xls
xlsx

### better
docx

### bad
csv

### no change
pdf


# ref
my article
http://qiita.com/keitasumiya/items/4b2b1f6269413225b7cd

references
http://naruoga.hatenablog.com/entry/2015/12/21/201558#fn-936ec94d
http://qiita.com/motomiya326/items/c16038b670927468b89b
http://qiita.com/y_irabu/items/5d916562744b05c5fc82
https://www.libreoffice.org/get-help/install-howto/os-x/

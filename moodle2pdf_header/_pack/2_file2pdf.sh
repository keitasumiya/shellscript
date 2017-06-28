#!/bin/sh
cd file/
for i in `ls | grep -v .pdf`; do soffice --headless --convert-to pdf:writer_pdf_Export $i; done

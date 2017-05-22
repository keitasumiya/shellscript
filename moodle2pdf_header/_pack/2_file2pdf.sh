#!/bin/sh
cd file/
soffice --headless --convert-to pdf:writer_pdf_Export *.doc
soffice --headless --convert-to pdf:writer_pdf_Export *.docx
soffice --headless --convert-to pdf:writer_pdf_Export *.pptx
soffice --headless --convert-to pdf:writer_pdf_Export *.ppt
soffice --headless --convert-to pdf:writer_pdf_Export *.xlsx
soffice --headless --convert-to pdf:writer_pdf_Export *.xls
soffice --headless --convert-to pdf:writer_pdf_Export *.txt
soffice --headless --convert-to pdf:writer_pdf_Export *.rtf
soffice --headless --convert-to pdf:writer_pdf_Export *.html

#!/bin/bash

filename=$(echo "$1" | cut -f 1 -d '.')

pandoc  $1 --listings --template=templates/template.tex -V lang=eu --pdf-engine=xelatex -o "$filename.pdf" 

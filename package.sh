#!/bin/bash
master=synbds-noise-synthetic-SJIAOS2015
# create a fls file
pdflatex -recorder ${master}.tex
# identify only the necessary files
grep -vE "share|aux|texmf|PWD" *fls  |\
 sed 's/^INPUT //;s/^OUTPUT //;s+^./++' |\
 sort | uniq > include.list
# add the bibliography file
# this could be consolidated using Jabref
ls -1 *bib *bst >> include.list
# get the svn revision
svn up
svn_info=$(svn info . | grep "^Revision" | awk '{ print $2 }')
svn_url=$(svn info . | grep "^URL" | awk '{ print $2 }')
# write comment
echo "Files from $svn_url @ $svn_info packaged by $(whoami) on $(date) on $(hostname)" > README.txt
echo "README.txt" >> include.list
# now package it all up
cat include.list | zip ${master}-submission.zip -@
# add comment
zip -z ${master}-submission.zip  < README.txt

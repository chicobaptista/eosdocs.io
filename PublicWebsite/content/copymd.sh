#!/bin/bash

find . -name "*.md"|while read fname; do

 echo "$fname"

 NEW_FNAME=`echo $fname | sed "s/\.\///g"`

 NEW_FNAME=`echo $NEW_FNAME | sed "s/\//_BARRA_/g"`

 NEW_FNAME=`echo $NEW_FNAME | sed "s/.md/.txt/g"`

 echo $NEW_FNAME

 cp "$fname" "/git/teste/$NEW_FNAME"

done

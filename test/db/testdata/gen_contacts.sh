#!/bin/sh

count=250

# get `count` top most popular names
cat $(dirname $0)/yob2014.txt | head -$count | cut -d, -f1 > tmp 

echo "" > tmp_contacts

while read p; do

    echo "insert into contact values (default, '$p');" >> tmp_contacts
    
done < tmp

mv tmp_contacts $(dirname $0)/contacts.sql
rm tmp

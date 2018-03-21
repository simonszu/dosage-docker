#! /bin/bash
# Change to root folder
cd /

# Fetch all comics, including adult ones and create html and rss pages
/usr/local/bin/dosage -o html -o rss @ --adult

# Copy the RSS feed to the html folder
#rm /Comics/html/dailydose.rss
cp /Comics/dailydose.rss /Comics/html/dailydose.rss

# Change to html folder
cd /Comics/html

# Fix the links
sed -i 's@file://@@g' *.html
sed -i 's@file://@@g' dailydose.rss
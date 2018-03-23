#! /bin/bash
# Change to root folder
cd /

# Fetch all comics, including adult ones and create html and rss pages
#/usr/local/bin/dosage -o html -o rss @ --adult
/usr/local/bin/dosage -o html @ --adult

# Create index if not existing
if [ ! -f /Comics/html/index.php ]; then
  cp /templates/index.php /Comics/html/index.php
fi

# Copy the RSS feed to the html folder
#rm /Comics/html/dailydose.rss
#cp /Comics/dailydose.rss /Comics/html/dailydose.rss

# Change to html folder
cd /Comics/html

# Fix the links
sed -i 's@file:///Comics@@g' *.html
#sed -i 's@file://@@g' dailydose.rss
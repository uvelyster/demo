#!/bin/sh
DATE=$(date)
echo $DATE >> /www/hksipnqdj9xq1twe/public_html/GIT/test.txt
git commit -am "$DATE commit!"
git push -u

echo "git clear"


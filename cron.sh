#!/bin/sh
DATE=$(date)
echo $DATE >> /www/hksipnqdj9xq1twe/public_html/GIT/test.txt
eval $(ssh-agent -s)
ssh-add ~/.ssh/git
git commit -am "$DATE commit!"
git push -u

echo "git clear"


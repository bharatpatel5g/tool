#!/usr/bin/bash






echo $(cat $1 | wc -l ) Target Loaded For Subdomain Scan

xargs -a $1 -P 50 -I % bash -c "./subenum1.sh %" 2> /dev/null 

cat domain/tmp/* | anew -q domain/domains 2> /dev/null 

echo Subdomain Scan Completed Total $(cat domain/domains | wc -l )  Subdomain Found 

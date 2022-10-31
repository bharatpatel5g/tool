#!/bin/bash
mkdir -p urls


   
    echo "Finding Urls With Waybackurls"
    xargs -a $1 -P 100 -I % bash -c "echo % | ~/tool/waybackurls" 2> /dev/null | ~/tool/anew -q urls/waybackurls.list
    
    echo "FILTERIN Urls To Uniq"
    cat urls/waybackurls.list 2> /dev/null | sed '/\[/d' |sort -u | ~/tool/anew -q urls/urls.txt # <-- Filtering duplicate and common endpoints
    cat urls.txt | grep = | ~/tool/anew -q urls/xss.txt
    echo "SCAN COMPLETE"


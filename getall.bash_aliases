#!/bin/bash
mkdir -p urls


getallurls(){
   
    echo "Finding Urls With Waybackurls"
    xargs -a live.txt -P 50 -I % bash -c "echo % | ~/tool/waybackurls" 2> /dev/null | anew -q urls/waybackurls.list
    echo "Finding Urls With Gau plus"
    xargs -a live.txt -P 50 -I % bash -c "echo % | ~/tool/gauplus -b eot,jpg,jpeg,gif,css,tif,tiff,png,ttf,otf,woff,woff2,ico,svg,txt" 2> /dev/null | anew -q urls/gau.list 2> /dev/null &> /dev/null
    echo "FILTERIN Urls To Uniq"
    cat urls/gau.list urls/waybackurls.list 2> /dev/null | sed '/\[/d' |sort -u | anew -q urls.txt # <-- Filtering duplicate and common endpoints
    
    
   
    xargs -a urls/xss.txt -P 30 -I % bash -c "echo % | ~/tool/kxss" 2> /dev/null | grep "< >\|\"" | awk '{print $2}' | anew -q urls/xssp.list
    echo "SCAN COMPLETE"
}
getallurls

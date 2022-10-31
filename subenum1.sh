#!/usr/bin/env bash



mkdir -p domain
mkdir -p domain/tmp


    
    curl -s "https://crt.sh/?q=%25.$1&output=json" | jq -r '.[].name_value' 2>/dev/null | sed 's/\*\.//g' | sort -u | grep -o "\w.*$1" | anew -q domain/tmp/domains_$1
    curl -s "https://api.hackertarget.com/hostsearch/?q=$1" | grep -o "\w.*$1" | anew -q domain/tmp/domains_$1
    curl -s "https://riddler.io/search/exportcsv?q=pld:$1" | grep -Po "(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | grep -o "\w.*$1" | anew -q domain/tmp/domains_$1
    assetfinder --subs-only $1 | anew -q domain/tmp/domains_$1
    subfinder -silent -d $1 -all -t 100 -o domain/tmp/domains_$1 &> /dev/null
    crobat -s $1 | anew -q domain/tmp/domains_$1
    curl -s "https://certspotter.com/api/v1/issuances?domain=$1&include_subdomains=true&expand=dns_names" | jq .[].dns_names 2>/dev/null | grep -Po "(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | anew -q domain/tmp/domains_$1
    curl -s "https://jldc.me/anubis/subdomains/$1" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u 2>/dev/null | anew -q domain/tmp/domains_$1
   curl https://api.securitytrails.com/v1/domain/$1/subdomains --header 'APIKEY: h7kMNSWW0jURChgflpF4z9gZhdcmzRgL'| jq .subdomains 2>/dev/null | awk -v domain=$1 -F\" '{print $2 "." domain}' | sed '$d' | sed '1d' | anew -q domain/tmp/domains_$1
   curl --silent https://sonar.omnisint.io/subdomains/$1 | grep -oE "[a-zA-Z0-9._-]+\.$1" | sort -u 2>/dev/null  | anew -q domain/tmp/domains_$1
   cat domain/tmp/domains_$1  | grep "$1" | sort -u |  anew -q domain/tmp/domains_$1
   
   




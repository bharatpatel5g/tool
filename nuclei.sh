#!/usr/bin/env bash



mkdir -p vulns




echo "Started Nuclei" 



xargs -a $1 -P 100 -I % bash -c "nuclei -target % -t ~/nuclei-templates/ -nc -s info -c 10 -silent" 2> /dev/null | anew -q vulns/nuclei.txt
xargs -a $1 -P 100 -I % bash -c "nuclei -target % -t ~/nuclei-templates/ -nc -s low -c 10 -silent" 2> /dev/null | anew vulns/nuclei.txt | notify -silent &> /dev/null
xargs -a $1 -P 100 -I % bash -c "nuclei -target % -t ~/nuclei-templates/ -nc -s medium -c 10 -silent" 2> /dev/null | anew vulns/nuclei.txt | notify -silent &> /dev/null
xargs -a $1 -P 100 -I % bash -c "nuclei -target % -t ~/nuclei-templates/ -nc -s high -c 10 -silent" 2> /dev/null | anew vulns/nuclei.txt | notify -silent &> /dev/null
xargs -a $1 -P 100 -I % bash -c "nuclei -target % -t ~/nuclei-templates/ -nc -s critical -c 10 -silent" 2> /dev/null | anew vulns/nuclei.txt | notify -silent &> /dev/null
   


echo "Nuclei Finished"
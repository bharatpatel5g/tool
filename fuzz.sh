#!/usr/bin/env bash

mkdir dirs



FUZZ_DIRS(){
    echo -e " STARTING DIRECTORY FUZZING ON it may take time"
    for target in $(cat $1); do
        fuzzout=$(echo $target | awk -F// '{print $NF}' | sed -E 's/[\.|:]+/_/g')
        ffuf -u $target/FUZZ -ac -t 100 -mc 200 -sf -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36" -w ~/wordlists/fuzz.txt -p '0.6-1.2' -e .html,.json,.php,.asp,.aspx,.log,.sql,.txt,.asp,.jsp,.bak,~,.db -maxtime 900 -o dirs/$fuzzout.json -s 2> /dev/null &> /dev/null
        cat dirs/$fuzzout.json | jq -r '.results[] | .status, .length, .url' 2> /dev/null | xargs -n3 | anew -q dirs/$fuzzout.txt
        rm -rf database/dirs/$fuzzout.json
        echo -e " finish"
    done
}
FUZZ_DIRS
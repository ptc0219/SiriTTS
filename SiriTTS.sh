#!/bin/bash

if [[ -z $1 ]]; then
    echo "Usage: $0 {filename}"
else
    filename="$1";

    mkdir -p SiriTTS_aiff
    mkdir -p SiriTTS_mp3

    count=1
    while read -r line
    do
        echo "Step 1. $line";
        echo $line | say -v Mei-Jia -o "SiriTTS_aiff/$count-$line.aiff";
        count=$(($count+1));
    done < "$filename"

    sleep 1;

    files=$(ls -1 SiriTTS_aiff);
    for i in $files
    do
        filename=$(echo $i | awk -F '.' '{print $1}';)
        echo "Step 2. $filename.aiff -> $filename.mp3";
        lame "SiriTTS_aiff/$filename.aiff" "SiriTTS_mp3/$filename.mp3";
    done
fi

#!/bin/bash

pactl list short sink-inputs|while read stream; do
    inputId=$(echo $stream|cut '-d ' -f2)
    streamId=$(echo $stream|cut '-d ' -f1)
    echo "inputId: $inputId"
    if [ "$inputId" == "1" ]; then
       newId=0
    elif [ "$inputId" == "0" ]; then
        newId=1
    fi
    
    echo "moving stream $streamId"
    pactl move-sink-input "$streamId" "$newId"

    #echo "newId: $newId"
done

#!/bin/bash

pactl list short sink-inputs|while read stream; do
    inputId=$(echo $stream|cut '-d ' -f2)
    streamId=$(echo $stream|cut '-d ' -f1)
    #echo "inputId: $inputId"
    if [ "$inputId" == "1" ]; then
       newId=0
       device="Headphones"
    elif [ "$inputId" == "0" ]; then
        newId=1
	device="Speakers"
    fi
    
    #echo "moving stream $streamId"
    pactl move-sink-input "$streamId" "$newId"
    echo "$device"
    #echo "newId: $newId"
done

#stream=$(pactl list short sink-inputs | grep running)
#deviceId=$(echo $stream|cut '-d ' -f1)

#if [ "$deviceId" == "1" ]; then
#	device="Speakers"
#elif [ "$deviceId" == "0" ]; then
#	device="Headphones"
#fi

#echo "$device"

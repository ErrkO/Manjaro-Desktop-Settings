#!/bin/bash

declare -a device

stream=$(pactl list short sinks | grep RUNNING)
deviceId=$(echo $stream|cut '-d ' -f1)

if [ "$deviceId" == "1" ]; then
    device="Speakers"
elif [ "$deviceId" == "0" ]; then
    device="Headphones"
fi
echo "$device"

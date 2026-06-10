#!/usr/bin/env sh

while true; do
    FAN_SPEED=$(sensors | grep -i 'cpu_fan' | grep -oP '\d+ RPM')

    echo $FAN_SPEED

    sleep 5
done

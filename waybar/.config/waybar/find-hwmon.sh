#!/bin/bash

linkPath="/tmp/temp-path"

tempDir=$(
for i in /sys/class/hwmon/hwmon*/temp*_input; do echo "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*})) $(readlink -f $i)"; done | grep k10temp | awk '{print $3}'
)

# echo $tempDir
ln -s $tempDir $linkPath
